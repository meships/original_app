# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name: '管理者',
    email: 'admin@example.jp',
    password: 'admin@example.jp',
    password_confirmation: 'admin@example.jp',
    admin: true)

labels = [
    {id: 1, name: "陸上"},
    {id: 2, name: "水上"},
    {id: 3, name: "水中"},

]
labels.each do |label|
    Label.find_or_create_by(label)
end



# ゲストユーザーを作成する
guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
  user.name = 'Guest User'
  user.password = SecureRandom.urlsafe_base64
end
  
  # ゲスト管理者を作成する
admin_guest_user = User.find_or_create_by!(email: 'admin_guest@example.com') do |user|
  user.name = 'Guest Admin User'
  user.password = SecureRandom.urlsafe_base64
  user.admin = true
end