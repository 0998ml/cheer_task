class Group < ApplicationRecord
  # グループにはたくさんのタスクが紐付く
  has_many :tasks
  
  # グループにはたくさんのユーザー（メンバー）がいる（招待機能用）
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  # 名前は必須にする
  validates :name, presence: true
end