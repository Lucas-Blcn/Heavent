# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
User.destroy_all
Event.destroy_all

puts "creating one User - heavent@gmail.com"

# Créer un User :
user_test = User.new(
  email: "heavent@gmail.com",
  password: "password",
  status: "student",
  pseudo: "Heavent#1410"
)

user_test.save!

puts "afficher le user"
puts "#{User.count}"


# Créer deux events:
price = ["5","10","12","14","15","18","20"]
tag = %w[arts_contemporain street_art theatre BD comédie balade cinema atelier humour peinture spectacle_musicale]
5.times do
  Event.create!(
    title: Faker::Lorem.sentence,
    chapeau: Faker::Lorem.paragraph,
    description: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    start_date: Faker::Time.between_dates(from: Date.today, to: Date.today + 30, period: :day),
    end_date: Faker::Time.between_dates(from: Date.today + 7, to: Date.today + 31, period: :day),
    description_date: "From #{:start_date} To #{:end_date}",
    url_image: Faker::Internet.url,
    type_of_price: ["gratuit", "payant"][rand(0..1)],
    price_details: "De #{price[rand(0..6)]} à #{price[rand()]} ",
    url_link: Faker::Internet.url,
    tags: "#{tag[rand(0..11)]},#{tag[rand(0..11)]}",
    place_name: Faker::Address.community,
    address: "#{Faker::Address.street_address}, Paris",
    zip_code: Faker::Number.between(from: 75000, to: 75020),
    gps_coord: "#{Faker::Address.latitude}, #{Faker::Address.longitude}",
    access: Faker::Lorem.sentence,
    url_to_book: Faker::Internet.url,
    background_image: Faker::Internet.url
  )
end

puts "afficher les events "
puts "#{Event.count}"
