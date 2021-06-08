    def create
      # DeleteThis - set new model with attributes as needed; no need for accessible by because model based auth
      @ChangeLoad = ChangeModel.new(ChangeAttributes)
      # DeleteThis - on create, assign create params BEFORE authorizing
      @ChangeLoad.assign_attributes(create_params)
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis - add logic and / or current user restrictions if necessary
      if @ChangeLoad.save
        flash[:success] = 'ChangeObject created.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        # DeleteThis - insert instance variables for template
        render 'ChangeTemplate'
      end
      # DeleteThis - add private section (if not already present) and create params
    end
