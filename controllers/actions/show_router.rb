  def show
    @cgn = cgn::cgn.find(params[:id])
    authorize! :cgn, @cgn
    #-- Redirect to First Authorized Tab With Model Based Auth --#
    if can? :cgn, @cgn
      redirect_to cgn_url(@cgn)
    elsif can? :cgn, @cgn
      redirect_to cgn_url(@cgn)
    end
  end
