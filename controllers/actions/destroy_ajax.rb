    def destroy
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis - add logic and / or current user restrictions if necessary
      if @ChangeLoad.destroy
        flash.now[:success] = 'ChangeObject deleted.'
        # DeleteThis - render method is automatically set to render 'destroy'. If rendering a file other than destroy.js then include it here explicitly
        # DeleteThis - see here for additional examples: https://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option (ex. render status: :no_content)
      else
        flash.now[:danger] = 'Failed to delete ChangeObject. See errors below.'
        render 'invalid_destroy'
      end
    end
