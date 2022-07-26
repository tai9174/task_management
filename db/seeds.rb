# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "kenji0",email:"kenji1@gmail.com",password:"kenjikenji1",admin: false)
User.create(name: "taro0",email:"taro1@gmail.com",password:"tarotaro1",admin: false)
User.create(name: "kenji2",email:"kenji2@gmail.com",password:"kenjikenji2",admin: false)
User.create(name: "taro2",email:"taro2@gmail.com",password:"tarotaro2",admin: false)
User.create(name: "kenji3",email:"kenji3@gmail.com",password:"kenjikenji3",admin: false)
User.create(name: "taro3",email:"taro3@gmail.com",password:"tarotaro3",admin: false)
User.create(name: "kenji4",email:"kenji4@gmail.com",password:"kenjikenji4",admin: false)
User.create(name: "taro4",email:"taro4@gmail.com",password:"tarotaro4",admin: false)
User.create(name: "kenji5",email:"kenji5@gmail.com",password:"kenjikenji5",admin: false)
User.create(name: "taro5",email:"taro5@gmail.com",password:"tarotaro5",admin: false)
User.create(name:  "admin",
  email: "admin@example.jp",
  password:  "11111111",
  admin: true)

# 配列でまとめて作成
labels = Label.create([{name: "A"}, {name: "B"}, {name: "C"}, {name: "D"}, {name: "E"}, {name: "F"}, {name: "G"}, {name: "H"}, {name: "I"}, {name: "J"}])
# ループでまとめて作成
10.times do |t|
  Task.create!(
              user_id:t+1,
              title: "title #{t+1}",
              content:"content #{t+1}",
              created_at:Date.today,
              updated_at:Date.today,
              expired_at:Date.today,
              status:rand(0..2),
              priority:rand(0..2),           
              )
end