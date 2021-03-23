    def index
      @pagy, @ChangeLoads = pagy(ChangeModel.accessible_by(current_ability, :ChangeNamespace_ChangePermission).search(params[:ChangeLoads_search]).index_scope)
      authorize!(:ChangeNamespace_ChangeVerb, :ChangeObjects)
      @ChangeLoads_searched = true unless params[:ChangeLoads_search].blank?
    end

