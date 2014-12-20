# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times do |n|
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(email: email,
               password:              password,
               password_confirmation: password)
end

users = User.all
20.times do
	title = "this is a task"
  description = Faker::Lorem.sentence(5)
  users.each { |user| user.tasks.create!(description: description, title: title) }
end


 