require 'faker'
require 'net/http'
require 'json'

puts "...Destroying database"
User.destroy_all
Event.destroy_all

puts "...Calling API Que faire A paris"
# title, lead_text, description, date_start, date_end, date_description, cover_url, tags, address_name, address_street, lat_lon, price_type, price_detail, address_zipcode, access_link
# URL de l'API avec les paramètres de la requête
url = URI.parse("https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/que-faire-a-paris-/records")
url.query = URI.encode_www_form(
  select: 'title, url, lead_text, description, date_start, date_end, date_description, cover_url, tags, address_name, address_street, lat_lon, price_type, price_detail, address_zipcode, access_link',
  limit: 2,
  refine: ['tags:"Peinture"', 'tags:"Art contemporain"', 'tags:"Théâtre"', 'tags:"Expo"', 'tags:"Spectacle musical"', 'tags:"Cinéma"', 'price_type:"payant"', 'price_type:"gratuit"']
)
# Récupérer la réponse
response = Net::HTTP.get_response(url)
# La mettre au format JSON
data = JSON.parse(response.body)
# Stocker la réponse
results = data['results']
# Itérer sur les éléments contenus dans le tableau results
results.each do |result|
  # to_array_tags = JSON.parse(result["tags"])
  # p to_array_tags
  r = Event.create!(
    title: result["title"],
    chapeau: result["lead_text"],
    description: result["description"],
    start_date: result["date_start"],
    end_date: result["date_end"],
    description_date: result["date_description"],
    url_image: result["cover_url"],
    type_of_price: result["price_type"],
    price_details: result["price_detail"],
    url_link: result["url"],
    tags: result["tags"],
    place_name: result["address_name"],
    address: result["address_street"],
    zip_code: result["address_zipcode"],
    gps_coord: result["lat_lon"],
    access: "",
    url_to_book: result["access_link"],
    background_image: ""
  )
end
puts "End of calling API Paris ... compter les events "
puts "#{Event.all}"

puts "... Calling Bestime API"
Event.all.each do |event|
  venue_name = event[:place_name]
  # venue_name = event[:place_name].gsub(/[èéêë]/, 'e')
  venue_address_init = event[:address]
  # venue_address_init = event[:address].gsub(/[èéêë]/, 'e')
  venue_address = "#{venue_address_init}, paris"

   # Utilisation de URI.encode_www_form_component pour encoder les composants de l'URL
   encoded_venue_name = URI.encode_www_form_component(venue_name)
   encoded_venue_address = URI.encode_www_form_component(venue_address)

   # Construction de l'URL en utilisant les composants encodés
   url_besttime = URI.parse("https://besttime.app/api/v1/forecasts?api_key_private=pri_baafc9f2302245cbb3c3b6bb1a98fd95&venue_name=#{encoded_venue_name}&venue_address=#{encoded_venue_address}")
   puts url_besttime

  # url_bestime = URI.parse("https://besttime.app/api/v1/forecasts?#{URI.encode_www_form(params)}")

  # Récupérer la réponse
  response = Net::HTTP.get_response(url_besttime)
  if response.is_a?(Net::HTTPSuccess)
    data = JSON.parse(response.body)
    puts data
  else
    puts "Error: #{response.code} - #{response.message}"
  end

end

# Event.all.each do |event|
#   venue_name = event[:place_name]
#   puts "venue_name: #{venue_name}"

#   venue_address_init = event[:address]
#   venue_address = "#{venue_address_init}, paris"

#   # Utilisation de Addressable::URI pour construire l'URL
#   url_besttime = Addressable::URI.parse("https://besttime.app/api/v1/forecasts")
#   url_besttime.query_values = {
#     api_key_private: 'pri_baafc9f2302245cbb3c3b6bb1a98fd95',
#     venue_name: venue_name,
#     venue_address: venue_address
#   }

#   puts url_besttime.to_s

#   # Récupérer la réponse
#   response = Net::HTTP.get_response(url_besttime)
#   if response.is_a?(Net::HTTPSuccess)
#     data = JSON.parse(response.body)
#     puts data
#   else
#     puts "Error: #{response.code} - #{response.message}"
#   end

# end


  puts "...Creating one User - heavent@gmail.com"

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


# # Créer deux events:
# price = ["5","10","12","14","15","18","20"]
# tag = %w[arts_contemporain street_art theatre BD comédie balade cinema atelier humour peinture spectacle_musicale]
# 5.times do
#   Event.create!(
#     title: Faker::Lorem.sentence,
#     chapeau: Faker::Lorem.paragraph,
#     description: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
#     start_date: Faker::Time.between_dates(from: Date.today, to: Date.today + 30, period: :day),
#     end_date: Faker::Time.between_dates(from: Date.today + 7, to: Date.today + 31, period: :day),
#     description_date: "From #{:start_date} To #{:end_date}",
#     type_of_price: ["gratuit", "payant"][rand(0..1)],
#     price_details: "De #{price[rand(0..6)]} à #{price[rand()]} ",
#     url_link: Faker::Internet.url,
#     tags: "#{tag[rand(0..11)]},#{tag[rand(0..11)]}",
#     place_name: Faker::Address.community,
#     address: "#{Faker::Address.street_address}, Paris",
#     zip_code: Faker::Number.between(from: 75000, to: 75020),
#     gps_coord: "#{Faker::Address.latitude}, #{Faker::Address.longitude}",
#     access: Faker::Lorem.sentence,
#     url_to_book: Faker::Internet.url,
#     background_image: Faker::Internet.url
#   )
# end
