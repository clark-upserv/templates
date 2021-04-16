    def update
      # DeleteThis - no need for accessible_by because of model based auth
      @ChangeLoad = ChangeModel.find(params[:id])
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      # DeleteThis - on update, assign update params AFTER authorizing otherwise user might be able to update model they should not have access to
      @ChangeLoad.assign_attributes(update_params)
      # DeleteThis - Note: authorization is not called after assignemnt... so make sure assignment is restricted with strong params and / or attribute value restrictions and / or adding additional authorization after assignment
      # DeleteThis - if html response
      if @ChangeLoad.save
        flash[:success] = 'ChangeObject updated.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to update ChangeObject. See errors below.'
        # DeleteThis - insert instance variables for template
        render 'ChangeTemplate'
      end
      # DeleteThis - if js response
      if @ChangeLoad.save
        flash.now[:success] = 'ChangeObject updated.'
        render 'update'
      else
        flash[:danger] = 'Failed to update ChangeObject. See errors below.'
        render 'invalid_update'
      end
    end
