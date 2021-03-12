# user roles control flow
if user.role?(:super_admin)
  # model based auth
  # the first attribute is an array of permissible actions  
  # the second attribute is the model to test against (you will test against a specific instance of the model when actually used)
  # the final hash is the restrictions (the user can only take the action on the instnace of the model if these condition are met)
  # the keys are database attributes or relationships
  # the values are anything you can come up with. Usually user.something or some scope ending in some logic. Can be an array.
  # every layer of hash is a relationship
  # simple example:
  can [:assign_documents], Office::Documents, owner_id: user.id
  # long example:
  can [:assign_documents], Office::Documents, owner_id: user.id, creator: { status: 'active', rank: ['primary', 'secondary'], account: { country_id: Country.where(zone: "Europe").pluck(:id) } }
  # symbol based auth
  # the first attribute is an array of permissible actions  
  # the second is a limitation of the permission 
  can [:assign], :documents
end
 
# Auth in controller actions:
  # Model Based
  authorize!(:assign_documents, @document)
  # Non-Model Based
  authorize!(:assign, :documents)

# can? method in views AND controllers
  # Model Based
  can?(:assign_documents, @document)
  # Non-Model Based
  can?(:assign, :documents)


# OLD

# for ability file: 
      #--- [App] App ---#
        # [App] Admin Role
        if user.role?(:app_admin)
          #- [App] App (Non-Model Based Auth) -#
          can [:show], :app
            
            # REVIEW use below for namespace sections and controllers
            # [Section] Section (Non-Model Based Auth)
            can [:show], :app_section
              # [Middle Path] Controller (Non-Model Based Auth)
              can [:show], :app_section_middle_path
           
            # REVIEW use below for resource sections and controllers
            # [Section] Resource Section Controller - (Index is Non-Model Based Auth since there is no singular @model instance (but rather @fesources) for index; Show is Model Based)
            can [:index], :app_section
            can [:show_app_section], App::Model, some_scope: user.some_attribute_or_method
              # [Middle Path] Controller (Model Based Auth)
              can [:show_app_section_middle_path], App::Model, some_scope: user.some_attribute_or_method

                # REVIEW use below for all final controllers regardless if withing a namespace or resource section
                # [Final Controller] Controller (Model Based Auth)
                can [:create_app_section_middle_path_final_controller, :update_app_section_middle_path_final_controller, :destroy_app_section_middle_path_final_controller], App::Model, some_scope: user.some_attribute_or_method
                # NOTE: create update and destroy are most common (so inlcuding those above). Sometimes there is a show. Could have any action or non-restful action as needed (although these are less common).

                
                  # [Final Controller] [Action] Load (Model Based Auth) 
                  # NOTE use any of the below anytime you need to laod specific resources within an action in either namespace OR resource controllers
                  can [:action_app_section_middle_path_final_controller_resources], App::Model, some_scope: user.some_attribute_or_method
                  # NOTE: user above if no differentiation is necessary, ex. index_hr_documents_docs
                  can [:action_app_section_middle_path_final_controller_status_resources], App::Model, some_scope: user.some_attribute_or_method
                  # NOTE: use above for mulitple indexes on the same template, ex. index_hr_documents_prepared_docs vs. index_hr_docuemnts_completed_docs
                  can [:action_app_section_middle_path_final_controller_model_nouns], App::Model, some_scope: user.some_attribute_or_method
                  # NOTE: user above if updating different instances differently within the same controller action, ex. update_hr_documents_docs_designation_prepararations & update_hr_documents_docs_designation_completions
                  can [:action_app_section_middle_path_final_controller_status_model_nouns], App::Model, some_scope: user.some_attribute_or_method
                  # NOTE: above is very unlikely to ever be needed, but is a combo of the 2 above it

# Auth in controller actions:
  # Model Based
  authorize!(:action_app_section_middle_path_final_controller, @model)
  # Non-Model Based
  authorize!(:action, :app_section_middle_path_final_controller)

# can? method in views AND controllers
  # Model Based
  can?(:action_app_section_middle_path_final_controller, @model)
  # Non-Model Based
  can?(:action, :app_section_middle_path_final_controller)
  # NOTE: can? and authroize! method attributes are structrued the exact same
