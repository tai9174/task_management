# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "kenji",email:"kenji@gmail.com",password:"kenjikenji")
User.create(name: "taro",email:"taro@gmail.com",password:"tarotaro")
User.create!(username:  "管理者",
  email: "admin@example.jp",
  password:  "11111111",
  password_confirmation: "11111111",
  admin: true)

Label.create(name:"A")
Label.create(name:"B")
Label.create(name:"C")
Label.create(name:"D")

# 配列でまとめて作成
# users = User.create([{name: "hanako"}, {name: "misa"}])
# ループでまとめて作成
# 3.times do |i|
# Article.create(user_id: User.find(i+1).id, title: "Star Wars #{i+1}")
# end