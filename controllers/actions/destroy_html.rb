    def destroy
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis - add logic and / or current user restrictions if necessary
      if @ChangeLoad.destroy
        flash[:success] = 'ChangeObject deleted.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to delete ChangeObject. See errors below.'
        # DeleteThis: insert instance variables for template
        render 'ChangeTemplate'
      end
    end

