class TasksController < ApplicationController
before_action :authenticate_user!
before_action :set_task, only: [:show, :edit, :update, :destroy]
before_action :set_user

  def index
  	@tasks = current_user.tasks.due_date >  time.now
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Task #{@task.title} created."
      @task.user.task_total += 1
      redirect_to @task
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
        @task.user.score += 1
        @task.save
      end
      redirect_to tasks_path
    else
      flash[:danger] = "Task creation faild"
      render 'edit'
    end
  end

  def destroy
     @task = Task.find(params[:id])
     if is_completed?
      redirect_to tasks_path
    else
      @task.user.task_total -= 1 #if the task isent compleat decrece the user score by 1
    end
      @task.delete
  end

  # collects tasks dew in the next 7 days 
  def weeks_tasks
    @tasks = []
    current_user.tasks.each do |task|
      @tasks << task if task.due_date > Time.now && task.due_date < Time.now+7.days
    end
  end

  def months_tasks
    due_time = Time.now
    month = due_time.mon
    @tasks = []
    current_user.tasks.each do |task|
      @tasks << task if task.due_date.mon == month
    end
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


