    def index
      # DeleteThis - authorize before loading records
      authorize!(:ChangeNamespace_ChangeVerb, :ChangeObjects)
      # DeleteThis - load records with accessible_by
      @ChangeLoads = ChangeModel.accessible_by(current_ability, :ChangeNamespace_ChangePermission)
    end

