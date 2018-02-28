class TodoList < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy

  validates :title, :user_id,
            presence: true,
            length: {maximum: 140}
end
