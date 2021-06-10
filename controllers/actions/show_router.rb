    def show
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      
      # Deletethis - Redirect to first authorized or raise access denied error
      if can?(:ChangeNamespace_ChangePermission, @ChangeModel)
        redirect_to ChangeUrl_url(@ChangeLoad)
      elsif can?(:ChangeNamespace_ChangePermission, @ChangeModel)
        redirect_to ChangeUrl_url(@ChangeLoad)
      else
        raise CanCan::AccessDenied
      end
    end
