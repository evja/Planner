class TasksController < ApplicationController
 before_action 
  def index
  	@tasks = Task.all
  end

  def show

  end

  def new
  end

  def edit
  end

  private

  def set_task
  	@task = task.find(task_params[:id])
  	def task_params
      params.require(:task).permit(:title, :description, :due_date,
                                   :is_complete, :complete_date )
    end
  end
end

create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_completed"
    t.datetime "completed_at"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"