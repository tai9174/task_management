class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user,only:[:show,:edit,:update,:destroy]

  def index
    @users = User.all.includes(:tasks).order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit

  end

  def create
    @user = current_user.tasks.build(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to task_url(@task), notice: "Task は作成されました！" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to (@task), notice: "Task は更新されました！" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "user は削除されました！" }
      format.json { head :no_content }
    end
  end

  
  private

  def if_not_admin
    redirect_to tasks_path flash[:notice] ="管理者以外はアクセスできません"unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_digest)
  end
end
