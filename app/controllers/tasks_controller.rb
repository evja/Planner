class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
  	@tasks = Task.all
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
      redirect_to @tasks
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_atributes(task_params)
      if @task.is_completed?
        @task.completed_at = Date.today
        @task.save
      end
      redirect_to @tasks
    else
      flash[:danger] = "Task creation faild"
      render 'edit'
    end
  end

  def destroy
     @task = Task.find(params[:id])
     @task.delete

     redirect_to root_path
  end


private

  def set_task
	 @task = task.find(task_params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date,
                                 :is_complete, :complete_date )
  end

end


