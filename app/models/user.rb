class User < ApplicationRecord
  #　rails標準のパスワード暗号化、認証機能を有効にする
  has_secure_password
  # ユーザーはたくさんのタスクを持っている 退会したときにタスクも消える
  has_many :tasks, dependent: :destroy

  has_many :cheers, dependent: :destroy

  has_many :comments, dependent: :destroy

  def cheered?(task)
    self.cheers.exists?(task_id: task.id)
  end

  # 空のまま登録するとエラーになる設定
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true #メールアドレスが必須かつ、重複不可
end
