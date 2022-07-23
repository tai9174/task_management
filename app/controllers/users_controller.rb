class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  
  def new
    redirect_to tasks_path if logged_in? 
    flash[:notice] ="すでにあなたはログインしていますよ。"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    if current_user.admin ==true
      @user = User.find(params[:id])
    elsif User.find(params[:id])== current_user
      @user = User.find(params[:id])
    else
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation,:admin)
  end
end
