class Task < ApplicationRecord
  #タスクは一人のユーザーに属している
  belongs_to :user

  has_many :cheers, dependent: :destroy

  # --- バリデーション：タイトルと内容は必須 ---
  validates :title, presence: true
  validates :body, presence: true
end
