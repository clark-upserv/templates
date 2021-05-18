    def destroy
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      if @ChangeLoad.destroy
 
      # DeleteThis: if html response
        flash[:success] = 'ChangeObject deleted.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to delete ChangeObject. See errors below.'
        # DeleteThis: insert instance variables for template
        render 'ChangeTemplate'
 
      # DeleteThis: if js response
        flash.now[:success] = 'ChangeObject deleted.'
        # DeleteThis - render method is automatically set to render 'destroy'. If rendering a file other than destroy.js then include it here explicitly
        # DeleteThis - see here for additional examples: https://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option (ex. render status: :no_content)
      else
        flash[:danger] = 'Failed to delete ChangeObject. See errors below.'
        render 'invalid_destroy'

      end
    end
