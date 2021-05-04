  def create
    @ChangeParent = ChangeParentModel.find(create_params[:ChangeParent_id])
    authorize! :ChangeAuth, @ChangeParent
    # DeleteThis: the line below should be refactored but works for now.. . it makes sure the submitted values match what is expected and no funny business has been done 
    raise unless create_params[:values].map { |id| id.to_i }.sort == @ChangeParent.ChangeChildren.pluck(:id).sort
    @ChangeParent.ChangeChildren.each do |ChangeChild|
      new_position = create_params[:values].find_index(ChangeChild.id.to_s) + 1
      ChangeChild.update_column(:position, new_position)
    end
    # DeleteThis: this should be refactored to have appropriate success and invalid responses
    render json: :no_content
  end

  def create_params
    params.require('ChangeStpId-stp-form').permit(:ChangeParent_id, values: [])
  end 
