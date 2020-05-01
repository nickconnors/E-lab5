class RecommendationsController < ApplicationController
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

  def show
    authorized?
    @recommendation = Recommendation.find(params[:id])
  end

  def index
    isAdmin?
    @recommendations = Recommendation.order(params[:sort])
  end

  def new
    authorized?
    @recommendation = Recommendation.new
  end

  def create
    authorized?
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.email = current_user.email
    if @recommendation.save
      redirect_to @recommendation
    else
      render 'new'
    end
  end

  def edit
    isAdmin?
    @recommendation = Recommendation.find(params[:id])

  end

  def update
    isAdmin?
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.update(recommendation_params)
      redirect_to @recommendation
    else
      render 'edit'
    end
  end


  private def recommendation_params
    params.require(:recommendation).permit(:firstname, :lastname, :dotnumber, :class_id)
  end

end
