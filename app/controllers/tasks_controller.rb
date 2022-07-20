class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order(created_at: :desc).page params[:page]
    @tasks=Task.all.order(expired_at: :desc).page params[:page] if params[:sort_expired_at]=="true"   
    @tasks=Task.all.order(priority: :desc).page params[:page] if params[:sort_priority]=="true" 
    if params[:search].present?
      if params[:search][:title].present? && params[:search][:status].present?
        @tasks =@tasks.search_title(params[:search][:title]).search_status(params[:search][:status])
      elsif params[:search][:title].present?
        @tasks =@tasks.search_title(params[:search][:title])
      elsif params[:search][:status].present?
        @tasks = @tasks.search_status(params[:search][:status])
      else
        @tasks = Task.all.order(created_at: :desc).page params[:page]
      end
      @tasks = @tasks.page(params[:page]).per(10)
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    @task = Task.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task は作成されました！" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task は更新されました！" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task は削除されました！" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :content,:expired_at,:status,:priority,:created_at)
  end
end
