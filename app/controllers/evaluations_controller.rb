class EvaluationsController < ApplicationController
  #authorizes user
  private def authorized?
    unless current_user.teacher? || current_user.admin?
      redirect_back(fallback_location: root_path)
    end
  end

  #check if user is admin
  private def isAdmin?
    unless current_user.admin?
      redirect_back(fallback_location: root_path)
    end
  end

  #single evaluation
  def show
    authorized?
    @evaluation = Evaluation.find(params[:id])
  end

  #all evaluations
  def index
    isAdmin?
    @evaluation = Evaluation.order(params[:sort])
  end

  def new
    authorized?
    @evaluation = Evaluation.new
  end

  def create
    authorized?
    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.email = current_user.email
    if @evaluation.save
      redirect_to @evaluation
    else
      render 'new'
    end
  end

  def edit
    isAdmin?
    @evaluation = Evaluation.find(params[:id])

  end

  private def evaluation_params
    params.require(:evaluation).permit(:firstname, :lastname, :dotnumber, :class_id, :rating, :review)
  end

end
