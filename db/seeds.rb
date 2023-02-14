# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(name: 'User One', email: 'notunique@example.com', password: 'mikepizza1258', password_confirmation:'mikepizza1258')
# User.create!(name: "meg", email:"meg@test.com", password: "test123", password_confirmation: "test123")
# User.create!(name: "Doe", email:"doe@test.com", password: "test32123", password_confirmation: "test123")

i = 1
20.times do 
    Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
    i+=1
end 