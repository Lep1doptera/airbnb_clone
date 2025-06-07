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

puts "Creating users..."

users = []
30.times do
  users << User.create!(
    email: Faker::Internet.unique.email, 
    password: "password123",
    password_confirmation: "password123"
  )
end

puts "..Creating properties..."

properties = []
30.times do
  user = users.sample

  properties << Property.create!(
    property_address: Faker::Address.full_address,
    number_of_guests: Faker::Number.between(from: 1, to: 10),
    description: Faker::Lorem.sentence(word_count: 12),
    price_per_night: Faker::Number.between(from: 50, to: 500),
    property_image_url: Faker::LoremFlickr.image(size: "640x480", search_terms: ['house', 'apartment']),
    users_id: user.id
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
    properties_id: property.id,
    users_id: user.id
  )
end


puts "Seeding Done"
