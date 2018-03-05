class AddDeadlineAtToTodoItems < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_items, :deadline, :datetime
  end
end
