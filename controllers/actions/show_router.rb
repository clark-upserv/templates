    def show
      @ChangeLoad = ChangeModel.find(params[:id])
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      
      # Redirect to first authorized
      if can?(:ChangeNamespace_ChangePermission, @ChangeModel)
        redirect_to ChangeUrl(@ChangeLoad)
      elsif can?(:ChangeNamespace_ChangePermission, @ChangeModel)
        redirect_to ChangeUrl(@ChangeLoad)
      end
    end
