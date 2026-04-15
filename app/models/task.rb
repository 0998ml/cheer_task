class Task < ApplicationRecord
  #タスクは一人のユーザーに属している
  belongs_to :user
  has_many :cheers, dependent: :destroy
  has_many :comments, dependent: :destroy

  # キーワードを受け取って、タイトルか本文に一致するものを探す 検索のルール（scope）
  scope :search_by_keyword, ->(keyword) {
    where('title LIKE ? OR body LIKE ?', "%#{keyword}%", "%#{keyword}%")
}
  # タイトルは必須
  validates :title, presence: true
end
