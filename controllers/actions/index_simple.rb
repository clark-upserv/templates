    def index
      # DeleteThis - authorize before loading records
      authorize!(:ChangeNamespace_ChangeVerb, :ChangeObjects)
      # DeleteThis - add logic and / or current user restrictions if necessary
      # DeleteThis - load records with accessible_by
      @ChangeLoads = ChangeModel.accessible_by(current_ability, :ChangeNamespace_ChangePermission)
    end

