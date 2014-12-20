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

  def edit
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


