class UsersController < ApplicationController
  #authorize user
  before_action :authorized?
  private def authorized?
    unless current_user.admin?
      # go to previous page before request, backup is home page
      redirect_back(fallback_location: root_path)
    end
  end

  #all users
  def index
    @users = User.all
  end

  #single user
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :teacher, :admin)
  end

end