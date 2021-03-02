  def show
    @cgn = cgn::cgn.find(params[:id])
    authorize! :cgn, @cgn
  end
