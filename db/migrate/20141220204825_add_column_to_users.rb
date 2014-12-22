class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, default: 0
    add_column :users, :task_total, :integer, default: 0
  end
end
