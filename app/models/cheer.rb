class Cheer < ApplicationRecord
  belongs_to :user
  belongs_to :task

  # タスク(task_id)に対して、同じ人(user_id)は1回しか保存できない
  validates :user_id, uniqueness: { scope: :task_id }
end
