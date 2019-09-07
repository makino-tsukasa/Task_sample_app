# coding: utf-8

User.create!( name: "管理ユーザー",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
100.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(3)
50.times do
  name = Faker::Lorem.sentence
  content = Faker::Lorem.sentence(3)
  users.each { |user| user.tasks.create!(name: name,
                                         content: content) }
end