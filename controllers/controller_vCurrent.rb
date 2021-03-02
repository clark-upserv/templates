replace:
model
Model
Model_ (for flash with 2 word models, you want "Answer option", not "AnswerOption" or "answer_option")
resources
fpp
App
section
middle_path_ (if no middle_path_, make sure to also delete the trailing underscore)
final_controller

  #--- Call Before Methods ---#
  # NOTE: DO NOT USE LOAD RESROUCE IF LOADING MANUALLY WITH ACCESSIBLE_BY.  
  # NOTE: Also, if you use load_resource, make explicit note of loaded model ("# cancancan alreadly loaded this but I'm includeing here to be explidit" folowed by @model on next line
  # NOTE: Lastly, remember for new & create, cancancan loads @model with scopes set in ability. For create it also adds strong params in this priority: create_params, model_params, resource_params
  # [standard]  
  load_resource
  # [model with name that doesn't match controller name and is not a parent of a nested resource]  
  load_resource :model, parent: false
  # [model with namespace that doesn't match controller namespace name OR load that doesn't match model name (I think?)]
  load_resource :model, class: "App::Model"
  # [model with name that doesn't match controller name AND namespace that doesn't match the controller namespace]  
  load_resource :model, parent: false, class: "App::Model"
  # [nested shallow resource]
  # NOTE: if only need to load parent on a parent / child nested resource, then use one of the above
  # NOTE: cancancan will load @parent on index, new, & create. It will load @child on all? OR just on show, edit, upddate & destroy? (I need to confirm) 
  # NOTE: use shallow loading even if nested resource is not shallow because you don't always need both the parent and the child (I think???)
  load_resource :parent, class: "App::ParentModel"
  load_resource :model, class: "App::ChildModel", parent: false, through: :parent, shallow: true
  
  #--- Actions ---#
  def index
    # @resources manual load refined with search params and index scope from model (if needed)
    @pagy, @resources = pagy(App::Model.accessible_by(current_ability, :index).search(params[:resources_search]).index_scope)
    # Non-Model Based Auth (index uses non-model based since there is no @model (but rather @resources)
    authorize! :index, :fpp_section
    # cancancan breaks with lower ordering so you may have to load manually. NEED TO FIGURE THIS OUT EVENTUALLY
    #@pagy, @resources = pagy(App::Model.joins(:core_user).where('core_users.account_id = ?', current_user.account_id).with_model_role.search(params[:search]).order('LOWER(core_users.first_name)').order('LOWER(core_users.last_name)'))
    # show a clear button if the page has an active search
    @resources_searched = true if !params[:resources_search].blank?
  end

  # [generic show]
  def show
    #-- Set Main Laad and Auth --# 
    # @model manual load - do not use accessible_by because authorize! method will also check load 
    @model = App::Model.find(params[:id])
    # Model Based Auth
    authorize! :show_fpp_section_middle_path_final_controller, @model

    #-- Set Additional Loads as Needed --# 

  end

  # [show - resource section controller without tabs]
  def show
    #-- Set Main Laad and Auth --# 
    # @model manual load - do not use accessible_by because authorize! method will also check load 
    @model = App::Model.find(params[:id])
    # Model Based Auth
    authorize! :show_fpp_section, @model

    #-- Set Additional Loads as Needed --# 

  end

  # [show - resources section controller with tabs]
  def show
    #-- Set Main Laad and Auth --# 
    # @model manual load - do not use accessible_by because authorize! method will also check load 
    @model = App::Model.find(params[:id])
    # Model Based Auth
    authorize! :show_fpp_section, @model

    #-- Redirect to First Authorized Tab With Model Based Auth --#
    if can? :show_fpp_section_middle_path, @model
      redirect_to middle_path_fpp_section_path(@model)
    elsif can? :show_fpp_section_other_middle_path, @model
      redirect_to other_middle_path_fpp_section_path(@model)
    end
  end

  # [show - resources tab controller]
  def show
    #-- Set Main Laad and Auth --# 
    # @model manual load - do not use accessible_by because authorize! method will also check load 
    @model = App::Model.find(params[:id])
    # Model Based Auth
    authorize! :show_fpp_section_middle_path, @model

    #-- Set Additional Loads as Needed --# 

    # show tab
    @tab = "Tab Name"
  end

  # [show - namespaced section controller without tabs]
  def show
    # Non-Model Based Auth
    authorize! :show, :fpp_section
    
    #-- Set Additional Loads as Needed --# 
    
  end
  
  # [show for naemspaced section controller with tabs]
  def show
    # Non-Model Based Auth
    authorize! :show, :fpp_section

    #-- Redirect to First Authorized Tab With Non-Model Based Auth --#
    if can? :show, :fpp_section_middle_path
      redirect_to fpp_section_middle_path_path(@model)
    elsif can? :show, :fpp_section_middle_path
      redirect_to fpp_section_middle_path_path(@model)
    end
  end

  # [show for namespaced tab controller]
  def show
    # authorize acces to show page
    authorize! :show, :fpp_section_middle_path

    #-- Set Additional Loads as Needed --# 
    
    # show tab
    @tab = "Tab Name"
  end
  
  def new
    # @model manual load 
    @model = App::Model.new
    #authorize action 
    authorize! :new, :fpp_section_middle_path_final_controller
  end

  def create
    #-- set initial instance variables and assign attributes --# 
    # NOTE: create params and any other attribute assignments need to go BEFORE authorize (which is different from update) because we want to make sure the user has authorization to create the modal AFTER all attribu0tes have been set. 
    # @model manual load with non-param attributes - do not use accessible_by because authorize! method will also check load. NOTE: @model attributes need to match any scopes from the ability file or access will be denied
    @model = App::Model.new(non_param_attribute_1: value)
    # Assign Create Params.     @model.assign_attributes(create_params)
    # Model Based Auth
    authorize! :create_fpp_section_middle_path_final_controller, @model

    # [if using additional logic and / or param specific logic] #
    #-- additional and / or param specific logic --#
    # descrtion of logic 
    do_some_logic

    # [if html]
    #-- HTML validation flow control --#
    if @model.save
      # set flash
      flash[:success] = "Model_ created."

      #- insert additional logic on success (such as send email, etc.) -#

      # redirect
      redirect_to some_named_url
      # NOTE: use URL and not PATH for redirects
    else
    # NOTE: Try to always include invalid render, even if there should not be any possible way for it to fail because on production there will ALWAYS be a way it can fail and it's nearly impossible to debug without some sort of error
      # load instance variables from original controller action needed for invalid render  -#
      
      # insert additional logic on invalid (such as send email, etc.) -#

      # render new with errors
      render 'new'
    end

    # [if ajax]
    #-- AJAX validation flow control --#
    respond_to do |format|
      if @model.save
        #- insert additional logic on success (such as send email, etc.) -#

        # render create.js.erb
        format.js
      else
      # NOTE: Try to always include invalid render, even if there should not be any possible way for it to fail because on production there will ALWAYS be a way it can fail and it's nearly impossible to debug without some sort of error
        #- insert additional logic on invalid (such as send email, etc.) -#

        #- render invalid_create.js.erb -#
        format.js { render "invalid_create.js.erb" }
      end
    end 

  end

  def edit
    # @model manual load 
    @model = App::Model.accessible_by(current_ability, :edit).find(params[:id])
    #authorize action 
    authorize! :edit, :fpp_section_middle_path_final_controller
  end

  def update
    #-- set initial instance variables and assign attributes --#
    # @model manual load - do not use accessible_by because authorize! method will also check load. NOTE: @model attributes need to match any scopes from the ability file or access will be denied
    @model = App::Model.find(params[:id])
    # Assign any non-param related attributes that need to be assigned at update (ex. updated_by: current_user)
    @model.assign_attributes(non_param_attribute_1: value)
    # Model Based Auth
    authorize! :update_fpp_section_middle_path_final_controller, @model
    # Assign Update Params. NOTE: on update, we want to assign any attribute AFTER authorization (which is different from create) so that we know the user has access to the model BEFORE any changes were made. Otherwise a user could pull an instance they shouldn't have access to and then change some attributes to give them access when they never should have had it to start
    @model.assign_attributes(update_params)
    
    # [if using additional logic and / or param specific logic] #
    #-- additional and / or param specific logic --#
    # descrtion of logic 
    do_some_logic

    # [if html]
    #-- HTML validation flow control --#
    if @model.save
      # set flash
      flash[:success] = "Model_ updated."

      #- insert additional logic on success (such as send email, etc.) -#

      # redirect
      redirect_to some_named_url
      # NOTE: use URL and not PATH for redirects
    else
    # NOTE: Try to always include invalid render, even if there should not be any possible way for it to fail because on production there will ALWAYS be a way it can fail and it's nearly impossible to debug without some sort of error
      #- load instance variables from original controller action needed for invalid render  -#
      
      #- insert additional logic on invalid (such as send email, etc.) -#

      # render edit with errors
      render 'edit'
    end

    # [if ajax]
    #-- AJAX validation flow control --#
    respond_to do |format|
      if @model.save
        #- insert additional logic on success (such as send email, etc.) -#
    
        # render update.js.erb
        format.js
      else
      # NOTE: Try to always include invalid render, even if there should not be any possible way for it to fail because on production there will ALWAYS be a way it can fail and it's nearly impossible to debug without some sort of error
        #- insert additional logic on invalid (such as send email, etc.) -#
    
        # render invalid_update.js.erb
        format.js { render "invalid_update.js.erb" }
      end
    end 
  end
  
  def destroy
    #-- set initial instance variables and assign attributes --#
    # @model manual load - do not use accessible_by because authorize! method will also check load. NOTE: @model attributes need to match any scopes from the ability file or access will be denied
    @model = App::Model.find(params[:id])
    # Model Based Auth
    authorize! :destroy_fpp_section_middle_path_final_controller, @model

    # [if using additional logic and / or param specific logic] #
    #-- additional and / or param specrici logic --#
    # descrtion of logic 
    do_some_logic

    # [if html]
    #-- HTML validation flow control --#
    # true destroy
    # NOTE: if deactivating rather than destroying, change to "deactivate destroy" 
    if @model.destroy
    #NOTE: if deactivating replace with: if @model.update(deactivated: true)
      # set flash
      flash[:success] = "Model_ deleted."
      # NOTE: if deactivating, consider replacing with: flash[:info] = "Model_ deleted. You can recover deleted resources by clicking the view deleted resources link within the next 60 days."

      #- insert additional logic on success (such as send email, etc.) -#

      # redirect

      # NOTE: use URL and not PATH for redirects
    else
    # NOTE: Try to always include invalid render, even if there should not be any possible way for it to fail because on production there will ALWAYS be a way it can fail and it's nearly impossible to debug without some sort of error
      #- load instance variables from original controller action needed for invalid render  -#
      
      #- insert additional logic on invalid (such as send email, etc.) -#

      # render with errors
      render 'some_template'
    end

    # [if ajax]
    #-- AJAX validation flow control --#
    # true destroy
    # NOTE: if deactivating rather than destroying, change to "deactivate destroy"
    respond_to do |format|
      if @model.destroy
      #NOTE: if deactivating replace with: if @model.update(deactivated: true)
        #- insert additional logic on success (such as send email, etc.) -#
    
        # render update.js.erb
        format.js
      else
      # NOTE: Try to always include invalid render, even if there should not be any possible way for it to fail because on production there will ALWAYS be a way it can fail and it's nearly impossible to debug without some sort of error
        #- insert additional logic on invalid (such as send email, etc.) -#
    
        # render invalid_destroy.js.erb
        format.js { render "invalid_destroy.js.erb" }
      end
    end 
  end

  #--- private ---#
    private 
    #-- Create strong params --#
    def create_params
      params.require(:fpp_model).permit(:attribute_1, :attribute_2, child_attributes: [:child_att_1, :_destroy])
    end

    #-- Update strong params --#
    def update_params
      params.require(:fpp_model).permit(:attribute_1, :attribute_2, child_attributes: [:child_att_1, :_destroy])
    end

    # [if using complex params, copy / paste this into create and / or update and / or any other params necessary and update "update"]
    def complex_params
      # [if using dynamic params]
      # set base params
      p = []
      # Some scenario
      p |= [:attribute_1, :attribute_2, child_attributes: [:child_att_1, :_destroy]] if some_logic
      # set create params
      update_params = params.require(:fpp_model).permit(p)

      # [if processing params]
      # fix select2 nil
      update_params[:attribute] =  nil if update_params[:attribute] == "0"

      # [if using attribute scopes (limitations on current user within attributes current user has access to)]
      # description of scope / logic
      if [some logic - USE CANCANCAN!]
        # raising instead of adding error because any errors added will be cleared before methods like .valid? or .save are called (therefore adding errors is worthless - need to check if there's another way to do add errors from controller. Regardless, this logic should only happen with tom-foolery SO user shouldn't get an error message anyways)
        raise
      end    
      
      # return final update params
      update_params
    end

    #-- Before methods --#
    #-- Controller methods --#
