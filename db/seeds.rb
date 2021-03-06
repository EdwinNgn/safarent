# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Review.destroy_all
Booking.destroy_all
Animal.destroy_all
User.destroy_all
Booking.destroy_all
Review.destroy_all

addresses = ['55 rue du faubourg Saint Honoré, 75008 Paris', '16 rue Nationale, 59800 Lille', '16 Villa Gaudelet, 75011 Paris', '8 rue Solferino, 75007 Paris', '5 rue de la Pompe, 75016 Paris']

user = User.create(email: "test@gmail.com", password: "azertyuiop")
#je ne crée que des chiens pour l'instant plus simple :)
5.times do |index|
  user = User.create(email: Faker::Internet.email, last_name: Faker::Name.last_name,first_name: Faker::Name.first_name, password: Faker::Alphanumeric.alpha(number: 8))
  p user
  name = Faker::Creature::Dog.name
  animal_type = "dog"
  species = Faker::Creature::Dog.breed
  price= rand(30..50)
  description = Faker::Creature::Dog.meme_phrase
  address = addresses[index-1]
  animal = Animal.create(user: user, name: name, animal_type: animal_type, species: species, price_per_day: price, location: "Lille", description: description, address: address)
  p animal
end
