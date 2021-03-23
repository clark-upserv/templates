    def show
      @ChangeLoad = ChangeModel.find(params[:id])
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      @tab = 'ChangeTab'
    end
