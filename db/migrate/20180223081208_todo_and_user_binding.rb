class TodoAndUserBinding < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :user_id, :integer
    add_column :todo_items, :priority, :integer, default: 0
  end
end
