    def show
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      
      # Redirect to first authorized
      if can?(:ChangeNamespace_ChangePermission, @ChangeModel)
        redirect_to ChangeUrl(@ChangeLoad)
      elsif can?(:ChangeNamespace_ChangePermission, @ChangeModel)
        redirect_to ChangeUrl(@ChangeLoad)
      end
    end
