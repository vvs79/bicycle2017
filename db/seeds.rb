# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create!(name: 'sport')
Category.create!(name: 'movie')
Category.create!(name: 'social')
Category.create!(name: 'fame')
Category.create!(name: 'politic')
Category.create!(name: 'school')
Category.create!(name: 'world')
User.create!(login: 'admin', email: 'admin@mail.com', password: '654321', admin: true)
category_id = 1
3.times do |i|
  user = User.create!(login: 'user' + i.to_s, email: 'mail' + i.to_s + '@mail.com', password: '123456', admin: false)
  10.times do |j|
    category_id += j
    category_id = 1 if category_id > 7
  	Bike.create!(name: 'bike_' + i.to_s + j.to_s, description: 'description for bike_' + i.to_s + j.to_s, user_id: user.id, used_bike: '', category_id: category_id)
  end
end
