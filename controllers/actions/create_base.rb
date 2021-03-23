    def create
      @ChangeLoad = ChangeModel.new(ChangeAttributes)
      # DeleteThis: on create, assign create params BEFORE authorizing
      @ChangeLoad.assign_attributes(create_params)
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis: if html response
      if @ChangeLoad.save
        flash[:success] = 'ChangeObject created.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        # DeleteThis: insert instance variables for template
        render 'ChangeTemplate'
      end
      # DeleteThis: if js response
      if @ChangeLoad.save
        flash.now[:success] = 'ChangeObject created.'
        render 'create'
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        render 'invalid_create'
      end
    end
