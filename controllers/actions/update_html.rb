    def update
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis - add logic and / or current user restrictions if necessary
      # DeleteThis - on update, assign update params AFTER authorizing otherwise user might be able to update model they should not have access to
      @ChangeLoad.assign_attributes(update_params)
      # DeleteThis - Note: authorization is not called after assignemnt... so make sure assignment is restricted with strong params and / or attribute value restrictions and / or adding additional authorization after assignment
      if @ChangeLoad.save
        flash[:success] = 'ChangeObject updated.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to update ChangeObject. See errors below.'
        # DeleteThis - insert instance variables for template
        render 'ChangeTemplate'
      end
      # DeleteThis - add private section (if not already present) and update params
    end