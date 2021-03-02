# Routes
  #--- [App Name] App ---#
  namespace :app do

    #-- [Section] Section (Type: Namespace) --# 
    # [Section] Controller. 
    get :section, to: 'section#show'
    # NOTE: this will be to a show page OR to a tab router depending on if there are tabs or not
    # [Section] Namespace
    namespace :section do 
      #- Middle Path -#
      # [Middle Path] Tab or Subsection Controller
      get :middle_path,  to: "middle_path#show"

      #- Final Controllers -#
      # [Middle Path] Final Controllers
        # [Final Controller] Controller
        resources :middle_path_final_controller, only: [:create, :update, :destroy], controller: "middle_path/final_controller"
        # NOTE: app and section namespace method remove the need to include "app_section" in the above resources method inside a namespace section. Resource sections (below) are a little different)
        # NOTE: resource controllers could also have an index, show, new or edit if it is like a subsection on a new page. But that is less often
    end

    #-- Section Section (Type: Resource) --#
    # [Section] Controller. 
    resources :section, only: [:index, :show] do
    # NOTE: show action will be to a show page OR to a tab router depending on if there are tabs or not
      #- Middle Path -#
      member do
        # [Middle Path] Tab or Subsection Controller
        get :middle_path,  to: "section/middle_path#show"
      end

      #- Final Controllers -#
      # [Middle Path] Final Controllers
        # [Final Controller] Controller
        resources :middle_path_final_controller, only: [:create, :update, :destroy], controller: "section/middle_path/final_controller"
        # NOTE: on first argument, you do not need app or section; on controller option, you do not need app BUT you do need section. Namespace method takes care of app but resources does not take care of section
        # NOTE: child resource controllers could also have an index, show, new or edit if it is like a subsection on a new page. But that is less often
    end

  end


# Paths & Url Helpers
# 6 things to check: 
  # base route: app_section_resource_path(id: model.id)
  # 1: is it a member route (resource tabs / subsections only)? If yes, it will start with tab_or_subsection and then go like normal 
  # 2: section - if it's a namespace controller, the section is the section name. If it is a resource controller, it will be the singular form of the model name 
  # 3: check that the middle path is correct
  # 4: resource - plural for index & create. singular for show, update, destroy  
  # NOTE: I forget the rules for new and edit since I never use those actions
  # 5: don't forget to include "_path" or "_url"!!!!
  # 6: be explicit with id & parent id - "(parent_id: parent.id, id: @model.id)" 
  # NOTE: only include parent id if recourse controller
 

# Section Helpers
  # Namespace Section (GET Route Method)
  app_section_path
  # NOTE: "section" above is the exact name of the section 

  # Resource Section - Index (Resources Route Method)
  app_sections_path
  # NOTE: "sections" above is the plural form of the model 

  # Resource Section - Show (Resources Route Method)
  app_section_path(id: model.id)
  # NOTE: "section" above is the singular form of the model 

# Middle Path Helpers
  # Namespace Middle Path - usually for a tab (GET Route  Method)
  app_section_middle_path_path

  # Resource Middle Path - usually for a tab (Member Route Route Method) 
  middle_path_app_section_path(id: model.id)
  # NOTE: "section" above is the singular form of the model 

# Index & Create Helpers
  # Namespaced Resource Index / Create (Resources Route Method)
  app_section_middle_path_final_controllers_path
  # NOTE: "final_controllers" above is the plural form of the model 

  # Nested Resource Index / Create (Resources Route Method)
  app_section_middle_path_final_controllers_path(id: parent.id)
  # NOTE: "section" above is the singular form of the PARENT model 
  # NOTE: "final_controllers" above is the plural form of the CHILD model 

# Show, Update & Destroy Helpers
  # Namespaced Resource Show / Update / Destroy (Resources Route Method)
  app_section_middle_path_final_controller_path(id: model.id)
  # NOTE: "final_controller" above is the singular form of the model 

  # Nested Resource Index / Show / Update / Destroy (Resources Route Method)
  app_section_middle_path_final_controller_path(parent_id: parent.id, id: child.id)
  # NOTE: "section" above is the singular form of the PARENT model 
  # NOTE: "final_controller" above is the singular form of the CHILD model 

# New & Edit Helpers
  # Namespaced Resource New (Resources Route Method)
  ???

  # Namespaced Resource Edit (Resources Route Method)
  ???
    
  # Nested Resource New (Resources Route Method)
  ???

  # Nested Resource Edit (Resources Route Method)
  ???

# NOTE: shouldn't ever actually route to namespaced or nested resource index, show, new or edit because those live on the namespace or resource section or tab template (the index / show / new / edit are nested and therefore don't get their own template, but I'm including them here just for theory) 
# NOTE: for the namespaced and nested resources, you really only care about create, update and destroy




# old notes / iron out:
# NOTE Typically, if not nested, some_path(@model) will automatically set id param to @model.id
# NOTE Typically, if nested but parent and child are same model, some_path(@model) will automatically set id param to @model.id AND parent_id param to @model.id
# NOTE However, sometimes after re-rendering with AJAX, the id param will get set to @model instead of @model.id in the above scenarios which causes a ActionView::Template::Error (No route matches… ) error (even though the named paths worked before the ajax
# NOTE So, since there could be issues with AJAX and because @model is not explicit, we are going to default to explicitly setting params in named paths (see examples below)



OLD STUFF
# resources
  resources :resources, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  name in url - generated form ":resrouces"
  actions created - all 7 OR only the actions specified in "only: [...]"
  name of controller - generated from ":resources" above or specify with "controller: 'resources'"
  name in named route - generated from ":resources" above or specify with "as: resources"

# standard namespace
namespace :namespace do
  resources :resources, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end

# change name of resource in url
namespace :namespace do 
  resources :changed_resources, controller: 'resources', only: [:index, :create, :destroy], as: 'resources'
  # note: there is an "as:" in the scope and in the resources. They  both impact the named route - the scope "as:" impacts namespace of named route and the resources "as:" impacts the resource of the named route
end

# scopes
  scope - sets the url just after the root
  module -  sets the namespaced folder name
  path - sets the url just before the resources
  as - sets the namespace in the named routes. This is important because various rails helper methods will naturally include the namespace in the named route (ex. form_with) so you want to keep the namespace in the named routes if you  want those methods to work (otherwise, you will have to specify the url manually every time)

# use scope to eliminate namespace from url
scope module: 'namespace', as: 'namespace' do
  resources :model, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end

# use scope to change namespace in url
scope :changed_namespace, module: 'namespace', as: 'namespace' do
  resources :model, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
