class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  # statusが0なら招待中、1なら参加済み
  validates :status, presence: true

  # 同じユーザーが、同じグループに重複して登録されるのを防ぐルール
  validates :user_id, uniqueness: { scope: :group_id }
end
