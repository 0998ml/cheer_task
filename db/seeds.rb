# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

puts "CheerTASKのデータ作成を開始します..."

# 1人目：山田さん
User.find_or_create_by!(email: "yamada@example.com") do |user|
  user.name = "山田太郎"
  user.password = "password"
end

# 2人目：田中さん
User.find_or_create_by!(email: "tanaka@example.com") do |user|
  user.name = "田中次郎"
  user.password = "password"
end

puts "データ作成が完了しました！"