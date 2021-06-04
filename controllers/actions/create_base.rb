    def create
      # DeleteThis - set new model with attributes as needed; no need for accessible by because model based auth
      @ChangeLoad = ChangeModel.new(ChangeAttributes)
      # DeleteThis - on create, assign create params BEFORE authorizing
      @ChangeLoad.assign_attributes(create_params)
      # DeleteThis - model based auth
      authorize!(:ChangeNamespace_ChangePermission, @ChangeModel)
      if @ChangeLoad.save

        # DeleteThis - if html response
        flash[:success] = 'ChangeObject created.'
        redirect_to ChangeUrlHelper_url
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        # DeleteThis - insert instance variables for template
        render 'ChangeTemplate'

      # DeleteThis - if js response
        flash.now[:success] = 'ChangeObject created.'
        # DeleteThis - render method is automatically set to render 'create'. If rendering a file other than create.js then include it here explicitly
        # DeleteThis - see here for additional examples: https://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option (ex. render status: :no_content)
      else
        flash[:danger] = 'Failed to create ChangeObject. See errors below.'
        render 'invalid_create'

      end
      # DeleteThis - add private section and create params
    end
