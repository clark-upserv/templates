    def create
      # DeleteThis - set new model with attributes as needed; no need for accessible by because model based auth
      @ChangeLoad = ChangeModel.new(ChangeAttributes)
      # DeleteThis - on create, assign create params BEFORE authorizing
      @ChangeLoad.assign_attributes(create_params)
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis - add logic and / or current user restrictions if necessary
      if @ChangeLoad.save
        flash.now[:success] = 'ChangeObject created.'
        # DeleteThis - render method is automatically set to render 'create'. If rendering a file other than create.js then include it here explicitly
        # DeleteThis - see here for additional examples: https://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option (ex. render status: :no_content)
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        render 'invalid_create'
      end
      # DeleteThis - add private section (if not already present) and create params
    end
