class TasksController < ApplicationController
before_action :authenticate_user!
before_action :set_task, only: [:show, :edit, :update, :destroy]
before_action :set_user

  def index
  	@tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = @user.tasks.build
  end

  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Task #{@task.title} created."
      redirect_to user_task_path(@user, @task)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      if @task.is_completed?
        @task.completed_at = Date.today
        @task.save
      elsif 
        @task.save
      end
      redirect_to user_tasks_path
    else
      flash[:danger] = "Task creation faild"
      render 'edit'
    end
  end

  def destroy
     @task = Task.find(params[:id])
     @task.delete

     redirect_to user_tasks_path
  end


private

  def set_task
	  @task = Task.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date,
                                 :is_complete, :complete_date, :user_id )

  end

end


