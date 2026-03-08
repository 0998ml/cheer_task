class User < ApplicationRecord
  #　rails標準のパスワード暗号化、認証機能を有効にする
  has_secure_password

  # 空のまま登録するとエラーになる設定
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true #メールアドレスが必須かつ、重複不可
end
