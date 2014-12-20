class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer
    add_column :users, :task_total, :integer, default: 0
  end
end
