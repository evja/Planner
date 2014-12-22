class TasksController < ApplicationController

before_action :authenticate_user!
before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_is_completed]
before_action :set_user
before_action :list,  only: [:this_week, :this_month, :to_day]

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
      @task.user.task_total += 1
      @task.user.save
      redirect_to user_task_path(@user, @task)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      if @task.is_completed
        @task.completed_at = Date.today
        @task.user.score += 1
        @task.user.save
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
    if @task.is_completed
      redirect_to user_tasks_path
    else
      @task.user.task_total -= 1 #if the task isent compleat decrece the user score by 1
    end
    @task.delete
    redirect_to user_tasks_path
  end

  # collects tasks dew in the next 7 days
  def this_week
    @tasks = []
    @all_tasks.each do |task|
      @tasks << task if task.due_date > Time.now && task.due_date < Time.now+7.days
    end
  end
  # reterns the tasks dew in the curent month
  def this_month
    due_time = Time.now
    month = due_time.mon
    @tasks = []
    @all_tasks.each do |task|
      @tasks << task if task.due_date.mon == month
    end
  end
  #reterns the tasks due in to day
  def to_day
    @tasks = []
    t = Time.now
    today = t.yday
    @all_tasks.each do |task|
      @tasks << task if task.due_date.yday == today
    end
  end

  def set_score
    @score = :score / :task_total
  end

  def toggle_is_completed
    @task.toggle(:is_completed)
    @task.save
    redirect_to user_tasks_path
  end


  private

  # orders the users tasks by due_date
  def list
    @all_tasks = current_user.tasks.order(due_date: :asc)
  end

  # sets the curent task
  def set_task
	  @task = Task.find(params[:id])
  end

  # sets the curent user
  def set_user
    @user = current_user
  end

  # strong params for the task modle
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :is_completed, :complete_date, :user_id )
  end

end


