    def index
      # DeleteThis - authorize before loading records
      authorize!(:ChangeNamespace_ChangeVerb, :ChangeObjects)
      # DeleteThis - load records with accessible_by
      @pagy, @ChangeLoads = pagy(ChangeModel.accessible_by(current_ability, :ChangeNamespace_ChangePermission).search(params[:ChangeLoads_search]).index_scope)
      # DeleteThis - include this if searching is enabled
      @ChangeLoads_searched = true unless params[:ChangeLoads_search].blank?
    end
