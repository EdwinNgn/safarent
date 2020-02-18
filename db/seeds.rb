# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Animal.destroy_all
User.destroy_all
Booking.destroy_all
Review.destroy_all

#je ne crée que des chiens pour l'instant plus simple :)
5.times do
  user = User.create(email: Faker::Internet.email, password: Faker::Alphanumeric.alpha(number: 8))
  p user
  name = Faker::Creature::Dog.name
  animal_type = "dog"
  species = Faker::Creature::Dog.breed
  price= rand(30..50)
  description = Faker::Creature::Dog.meme_phrase
  animal = Animal.create(user: user, name: name, animal_type: animal_type, species: species, price_per_day: price, location: "Lille", description: description)
  p animal
end
