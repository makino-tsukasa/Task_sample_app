class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: %i[show edit update destroy]
  before_action :logged_in_user
  before_action :correct_user
  
  def index
    @tasks = @user.tasks.order(created_at: "DESC")
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:success] = "#{@task.name}を更新しました"
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end
  
  def destroy
    if @task.destroy
      flash[:success] = "#{@task.name}を削除しました。"
      redirect_to user_tasks_url(@user, @task)
    else
      flash[:danger] = "#{@task.name}を削除できませんでした。"
      render :index
    end      
  end
  
  private
  
    def task_params
      params.require(:task).permit(:name, :content, :user_id)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_task
      @task = @user.tasks.find_by(id: params[:id])
    end
end