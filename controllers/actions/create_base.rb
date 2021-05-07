    def create
      # DeleteThis - set new model with attributes as needed; no need for accessible by because model based auth
      @ChangeLoad = ChangeModel.new(ChangeAttributes)
      # DeleteThis - on create, assign create params BEFORE authorizing
      @ChangeLoad.assign_attributes(create_params)
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      if @ChangeLoad.save

        # DeleteThis - if html response
        flash[:success] = 'ChangeObject created.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        # DeleteThis - insert instance variables for template
        render 'ChangeTemplate'

      # DeleteThis - if js response
        flash.now[:success] = 'ChangeObject created.'
        render 'create'
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        render 'invalid_create'

      end
    end
