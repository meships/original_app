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




# 5.times do |n|
#   User.create!(
#       name: "user#{n + 1}",
#       email: "user#{n + 1}@seed.com",
#       password: "user1@seed.com",
#       password_confirmation: "user1@seed.com",
#   )
# end

# users = User.all

# users = users.map{|user|user.id}

# start_day = Date.new(2020,1,1)
# last_day = Date.new(2023,12,31)

# 5.times{|n|
#     DailyReport.create!(
#         place: "現場名#{n + 1}",
#         date: rand(start_day..last_day),
#         address: "どこどこのどこ#{n + 1}",
#         action_content: "なになにのなに#{n + 1}",
#         tool: "それそれのそれ#{n + 1}",
#         user_id: users.sample
#     )
# }

# daily_reports = DailyReport.all
# daily_reports = daily_reports.map{|daily_report|daily_report.id}

# 5.times{|n|
#     Labelling.create(
#         label_id: rand(1..3),
#         daily_report_id: daily_reports.sample
#     )
# }


# ユーザーを作成する
5.times do |n|
  user = User.create!(
      name: "user#{n + 1}",
      email: "user#{n + 1}@seed.com",
      password: "password",
      password_confirmation: "password",
  )

  # 日報を作成する
  5.times do |m|
    daily_report = DailyReport.create!(
      place: "現場名#{m + 1}",
      date: Date.today + m,
      address: "どこの場所#{m + 1}",
      action_content: "何の作業#{m + 1}",
      tool: "どの道具#{m + 1}",
      latitude: 35.681236 + (rand(100)/1000.0),
      longitude: 139.767125 + (rand(100)/1000.0),
      user_id: user.id
    )

    # 日報にラベルを割り当てる
    Labelling.create!(
      label_id: (m % 3) + 1, # 1-3の間でランダムにラベルを選択する
      daily_report_id: daily_report.id
    )
  end
end