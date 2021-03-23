    def update
      @ChangeLoad = ChangeModel.find(params[:id])
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis: on update, assign update params AFTER authorizing
      @ChangeLoad.assign_attributes(update_params)
      # DeleteThis: if html response
      if @ChangeLoad.save
        flash[:success] = 'ChangeObject updated.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to update ChangeObject. See errors below.'
        # DeleteThis: insert instance variables for template
        render 'ChangeTemplate'
      end
      # DeleteThis: if js response
      if @ChangeLoad.save
        flash.now[:success] = 'ChangeObject updated.'
        render 'update'
      else
        flash[:danger] = 'Failed to update ChangeObject. See errors below.'
        render 'invalid_update'
      end
    end
