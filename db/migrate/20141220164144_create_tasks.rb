class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :is_completed
      t.datetime :completed_at
      t.datetime :due_date

      t.timestamps
    end
  end
end
