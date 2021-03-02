# main option definitions 
  # controller is the name of the controller - users in core/users_controller (this is for resoruces only, not scope)
  # module is the namespace in the controller path - core in core/users_controller
  # path is the namespace in the url - core in core/users
  # as is the "namespace" in the helper method - core in core_users_url
# preferences
  # namespace and automated version of resources preferred over scope and manual resources 
  # nested resources requires 2 resource methods (see below)
# Resources - automatically sets path, controller and as
resources :cgn, only: [:index, :show, :new, :create, :edit, :update, :destroy]
# resoources - set path, controller and as manually if needed
resources path: :cgn, controller: :cgn, as: :cgn, only: [:index, :show, :new, :create, :edit, :update, :destroy]

# individual routes 
get 'cgn', to: :cgn, as: :cgn
post 'cgn', to: :cgn, as: :cgn
patch 'cgn', to: :cgn, as: :cgn
delete 'cgn', to: :cgn, as: :cgn

# namespace - automatically sets path, module and as
namespace :cgn do 
  # insert resources or individual routes
end
# Scopes - set path, module as manually if needed
scope path: :cgn, module: :cgn, as: :cgn do
  # insert resources or individual routes
end

# Nesting routes under parent
# NOTE: when setting up parent resource and nested children resources, you have to have 2 separate methods because:
# if you tried to just controller path and as, parent would be core/users (good) and the children would be core/pets (bad)
# if you tried to use module, path and as the parent would be core/users/controller (bad) and the children would be core/users/pets (good)
# if you tried to use controller, module, path and as the parent would be core/users/users_controller (bad) and the children would be core/users/pets (good)
# so the solution is to have 2 separate methods and method used form nesting needs to have "only: []" so that the core/users/controller (which does not exist) is nullified
# now, each level of nesting does not have to repeat anything from previous scopes or resources AND nesting with resources works the same as nesting with scope
# This is the resources for nesting: 
rescources path: :cgn, module: :cgn, as: :cgn, only: [] do
  # insert resources or member routes
end

# Nested member routes
resources path: :cgn, module: :cgn, as: :cgn do
  member do
    # insert individual routes
  end
end
# Additional resource options
# param: : - will change param[:id] to param[:cgn]


# Using alternative attribute other than param - create to_param in model file. Ex: 
class User
  def to_param
    name #this attribute should be unique
  end 
end
 
# Notes on helper methods
  # resources
    # index and create are plural: 
    core_users_url
    # show, update, destroy are singular: 
    core_user_url(id: @user.id)
    # new: 
    new_core_user_url
    # edit: 
    edit_core_user_url
  # nested resources - parent is always singular
    # index and create are plural: 
    core_user_dogs_url
    # show, update, destroy are singular: 
    core_user_dog_url(id: @user.id)
    # new: 
    new_core_user_dog_url
    # edit: 
    edit_core_user_dog_url 
  # member routes under resource - parent is plural, memeber comes before parent, there is no child
    fun_test_user_url
  # individual routes will be exactly as they are written
    # namespace (or scope with module) of "picky" and get with as of "person" will give you:
    picky_person_url
  

# OLD:
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
