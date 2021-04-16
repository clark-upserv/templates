    def destroy
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis: if html response
      if @ChangeLoad.destroy
        flash[:success] = 'ChangeObject deleted.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to delete ChangeObject. See errors below.'
        # DeleteThis: insert instance variables for template
        render 'ChangeTemplate'
      end
      # DeleteThis: if js response
      if @ChangeLoad.destroy
        flash.now[:success] = 'ChangeObject deleted.'
        render 'destroy'
      else
        flash[:danger] = 'Failed to update ChangeObject. See errors below.'
        render 'invalid_destroy'
      end
    end
