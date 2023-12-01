require 'faker'
require 'net/http'
require 'json'
require 'pry-byebug'

puts "...Destroying database"
User.destroy_all
Interest.destroy_all
Event.destroy_all

puts "...Calling API Que faire A paris"
# title, lead_text, description, date_start, date_end, date_description, cover_url, tags, address_name, address_street, lat_lon, price_type, price_detail, address_zipcode, access_link
# URL de l'API avec les paramètres de la requête
url = URI.parse("https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/que-faire-a-paris-/records")
url.query = URI.encode_www_form(
  select: 'title, url, lead_text, description, date_start, date_end, date_description, cover_url, tags, address_name, address_street, lat_lon, price_type, price_detail, address_zipcode, access_link',
  limit: 10,
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
    address: "#{result["address_street"]}, paris",
    zip_code: result["address_zipcode"],
    gps_coord: result["lat_lon"],
    access: "",
    url_to_book: result["access_link"],
    background_image: ""
  )
end
puts "End of calling API Paris ... compter les events "

puts "... Calling Bestime API"

Event.all.each do |event|
  venue_name = URI.encode_www_form_component(event[:place_name])
  venue_address_init = event[:address]
  # venue_address = URI.encode_www_form_component("#{venue_address_init}, paris")
  venue_address = URI.encode_www_form_component(venue_address_init)

  affluences = []

  uri = URI("https://besttime.app/api/v1/forecasts?api_key_private=pri_baafc9f2302245cbb3c3b6bb1a98fd95&venue_name=#{venue_name}&venue_address=#{venue_address}")
  puts uri
  request = Net::HTTP::Post.new(uri)
  request['Content-Type'] = 'application/json'

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end
  puts response
  dataBesTime = JSON.parse(response.body)

  if dataBesTime["status"] == "OK"
    dataBesTime["analysis"].each do |analyse|
      affluence = {
        day_int: nil,
        day_text: nil,
        analysis: []
      }
      affluence[:day_int] = analyse["day_info"]["day_int"]
      affluence[:day_text] = analyse["day_info"]["day_text"]
      analyse["hour_analysis"].each do |hour_analysis|
        if !["Closed", "Above average", "High"].include?(hour_analysis["intensity_txt"])
          affluence[:analysis].push({ hour: hour_analysis["hour"], intensity_txt: hour_analysis["intensity_txt"] })
        end
      end
      affluences << affluence
    end
    Affluence.create!(name: dataBesTime["venue_info"]["venue_name"], days: affluences, event: event)
  end
  puts event.affluence
end
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
puts User.count
