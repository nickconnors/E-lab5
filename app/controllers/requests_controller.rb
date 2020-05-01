class RequestsController < ApplicationController
  #authorizes user
  private def authorized?
    unless current_user.teacher? || current_user.admin?
      redirect_back(fallback_location: root_path)
    end
  end

  #check if user is admin
  private def isAdmin?
    unless current_user.admin?
      # go to previous page before request, backup is home page
      redirect_back(fallback_location: root_path)
    end
  end

  #single request
  def show
    authorized?
    @request = Request.find(params[:id])
  end

  #all requests
  def index
    isAdmin?
    @requests = Request.order(params[:sort])
  end

  def new
    authorized?
    @request = Request.new
  end

  def create
    authorized?
    @request = Request.new(request_params)
    @request.email = current_user.email
    if @request.save
      redirect_to @request
    else
      render 'new'
    end
  end

  def edit
    isAdmin?
    @request = Request.find(params[:id])

  end


  private def request_params
    params.require(:request).permit(:firstname, :lastname, :dotnumber, :class_id, :section)
  end

end

