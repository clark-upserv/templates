Issue: when requiring trix WITH webpack, trix seems to load on page BEFORE any 
customizations (using the Trix variable) are added. This causes issues. For example
Trix will remove any HTML content tag that is not allowed. So you if you store in
the db an action text that include an html <trix-mark> tag (which is not an allowed 
tag), then that tag will be removed from the action text via js when the page 
is laoded. If you customize trix to allow <trix-mark> tags 
(Trix.config.textAttributes.highlight = {tagName: "trix-mark"}), then <trix-mark> tags will be
allowed BUT they will still be removed when the page loads because the customizations
are added AFTER the page / trix has already loaded and AFTER trix has already scrubbed 
the action text (because trix, at the point of  page load, was unaware of the 
customizations). HOWEVER, when trix is required outside of webpack, the customizations 
to trix are included BEFORE trix does it's magic but ONLY IF trix with customizations 
is loaded before the html <body> (or actually just as long as it's loaded before the 
<%= form.rich_text ... %>

Solution: see below 

ensure config is set up to initialize javascript manifest (there are several
ways to do this... this is just how I do it)
app/assets/config/manifest.js
```
// javascript packs are preferred over app/assets/javascripts but 
// app/assets/javascripts can be used if having issues with packs
//= link ../javascripts/application.js
```

ensure trix library can be used in javascript files under app/assets/javascripts
app/assets/javascripts/application.js
```
...
// add trix which is a one off / wierd scenario
// we need trix (which is added via yarn and lives in a node module and would typically be added via
// webpack) to be available in non-webpack js file
// = link trix/dist/trix
...
```

create customizations using trix library
app/assets/javascripts/lib/trix.js
```
// = require trix/dist/trix
Trix.config.textAttributes.highlight = {
  tagName: "trix-mark",
  inheritable: true 
}

$(document).ready(function(){trixSetUp()})
$(document).on('ajax:complete', function(){trixSetUp()})
// Make sure to include logic after ajax and also make sure to prevent duplicate events
function trixSetUp() {
  const highlightButtonHTML = '<button type="button" class="trix-button d-flex justify-content-center align-items-center" data-trix-attribute="highlight" title="highlight" tabindex="-1"><i class="fs-3 mdi mdi-font"></button>'
  $('trix-toolbar').each(function(index){
    if (!this.classList.contains('trix-set')) {
      this.classList.add('trix-set')
      const toolbar = this
      const italicButton = toolbar.querySelector(".trix-button--icon-italic")
      italicButton.insertAdjacentHTML("afterend", highlightButtonHTML)
    }
  })
}

//  other Trix customization opitons I've see but idk what they do...
//  styleProperty: "color: blue", // I don't think this one works
//  style: { color: "red" },
//  style: { color: 'red', backgroundColor: "blue" },
//  parser: function(element) {
//      return element.style.color === "red"
//  },
//  terminal: true,
//  breakOnReturn: true,
//  group: false
```

add customizations globally
app/views/layouts/application.html.erb
```
<head>
  ...
  <%# trix must be loaded before body for customizations to work.
  <%= javascript_include_tag('lib/trix') %>
  ...
</head>
```

make sure any ajax file triggers ajax complete event (in later versions of javascript, ajax:complete will not
triggered if the form which triggered the ajax call is replaced)
app/views/some_path/update.js.erb
```
// if replacing original form element, ajax:complete will not be triggered. Trigger manually below:
document.dispatchEvent(new Event('ajax:complete'));
```

style customizations
app/assets/stylesheets/some_stylesheet.scss
I use: app/assets/stylesheets/global/app.scss
```
trix-mark {
  background-color: #ffe30f;
}
```

add @rails/actiontext (tbh I'm not sure what this is but is part of typical trix installation)
app/javascript/packs/application.js
```
// trix is required outside of webpack in regular js (app/assets/javascript/lib/trix.js)
// but @rails/action text required here
require("@rails/actiontext")
```

Allow custom tags (and attributes) to be saved to database
config/application.rb
```
    config.to_prepare do
      ActionText::ContentHelper.allowed_tags << 'trix-mark'
    end

#    # additional options:
#    config.to_prepare do
#      ActionText::ContentHelper.allowed_attributes.add 'style'
#      ActionText::ContentHelper.allowed_tags << 'trix-mark'
#    end
#
#    # for global as opposed to just trix??? 
#    config.action_view.sanitized_allowed_tags = ['trix-mark']
#    config.action_view.sanitized_allowed_attributes = ['style']
```

Done!!!
