class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  # statusが0なら招待中、1なら参加済み
  validates :status, presence: true
end
