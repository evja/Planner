# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
  title = Faker::Name.name
  description = "example-#{n+1} task"
  Task.create!(title:  title,
               description: description,
               due_date:              5.days.from_now,
               is_completed: false,)
end
 