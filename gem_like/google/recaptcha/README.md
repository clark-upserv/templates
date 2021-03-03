- copy all files to your repo 
- add the following method in your layout head (if it does not already exist)
  - `<%= yield :head %>`
- add this to any page with a form that needs recapcha 
```
<%= content_for :recaptcha_js do %>
  <%= include_recaptcha_js %>
<% end %>
```

