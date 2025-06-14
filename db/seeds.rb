require 'faker'
require 'httparty'

UNSPLASH_ACCESS_KEY = "M0npxAy-_t1rmSstJVJsT1t6BdzosZ6f1j-rjheMOGk"

puts "Clearing existing data..."

Booking.destroy_all
Property.destroy_all
User.destroy_all

puts "✅ All records cleared."

puts "Creating users..."

users = []
20.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: "password123",
    password_confirmation: "password123"
  )
end

puts "..Creating properties..."

properties = []

real_melbourne_addresses = [
  "1 Swanston St, Melbourne VIC 3000",
  "100 Collins St, Melbourne VIC 3000",
  "250 Victoria St, Carlton VIC 3053",
  "18 St Kilda Rd, St Kilda VIC 3182",
  "200 Lygon St, Brunswick East VIC 3057",
  "12 Chapel St, South Yarra VIC 3141",
  "5 Smith St, Fitzroy VIC 3065",
  "300 Barkly St, Footscray VIC 3011",
  "99 Bay St, Port Melbourne VIC 3207",
  "75 Glenferrie Rd, Malvern VIC 3144",
  "60 Victoria Parade, East Melbourne VIC 3002",
  "210 Clarendon St, South Melbourne VIC 3205",
  "45 Toorak Rd, South Yarra VIC 3141",
  "155 Sydney Rd, Brunswick VIC 3056",
  "400 High St, Northcote VIC 3070",
  "33 Station St, Fairfield VIC 3078",
  "85 Kings Way, Southbank VIC 3006",
  "22 Glen Huntly Rd, Elwood VIC 3184",
  "70 Koornang Rd, Carnegie VIC 3163",
  "320 Nepean Hwy, Brighton VIC 3186"
]


def fetch_unsplash_images(query = "house", count = 10)
  url = "https://api.unsplash.com/photos/random?query=#{query}&count=#{count}&client_id=#{UNSPLASH_ACCESS_KEY}"
  response = HTTParty.get(url)
  if response.code == 200
    response.parsed_response.map { |img| img["urls"]["regular"] }
  else
    puts "❌ Failed to fetch images from Unsplash"
    []
  end
end

puts "Fetching Unsplash property images..."
property_images = fetch_unsplash_images("house apartment", 20)

puts "Creating properties with real images..."

real_melbourne_addresses.each do |property_address|
  properties << Property.create!(
    property_address: property_address,
    number_of_guests: rand(1..10),
    description: Faker::Lorem.sentence(word_count: 12),
    price_per_night: rand(50..500),
    property_image_url: property_images.sample,
    user_id: users.sample.id
  )
end

puts "..Creating bookings..."

5.times do
  property = properties.sample
  user = users.sample

  Booking.create!(
    check_in_date: Faker::Date.forward(days: 30),
    check_out_date: Faker::Date.forward(days: 40),
    booking_status: %w[pending confirmed cancelled].sample,
    number_of_guests: Faker::Number.between(from: 1, to: property.number_of_guests),
    property_id: property.id,
    user_id: user.id
  )
end


puts "Seeding Done"
