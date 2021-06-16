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
        flash.now[:success] = 'ChangeObject updated.'
        # DeleteThis - render method is automatically set to render 'update'. If rendering a file other than update.js then include it here explicitly
        # DeleteThis - see here for additional examples: https://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option (ex. render status: :no_content)
      else
        flash.now[:danger] = 'Failed to update ChangeObject. See errors below.'
        render 'invalid_update'
      end
      # DeleteThis - add private section (if not already present) and update params
    end