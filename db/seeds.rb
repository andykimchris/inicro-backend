require "faker"

include ActionDispatch::TestProcess

# Proprietor
proprietor = User.create!(email: Faker::Internet.email,
            password: "Johndoe123!", password_confirmation: 'Johndoe123!',
            is_occupant: false, is_proprietor: true,
            confirmed_at: Time.now.utc, confirmation_token: SecureRandom.base64)

# Occupants
User.create!(email: Faker::Internet.email,
            password: "Johndoe123!", password_confirmation: 'Johndoe123!',
            is_occupant: true, is_proprietor: false,
            confirmed_at: Time.now.utc, confirmation_token: SecureRandom.base64)

User.create!(email: Faker::Internet.email,
            password: "Janedoe123!", password_confirmation: 'Janedoe123!',
            is_occupant: true, is_proprietor: false,
            confirmed_at: Time.now.utc, confirmation_token: SecureRandom.base64)

location = Location.create!(
  name: Faker::Address.street_name,
  description: Faker::Lorem.paragraph,
  longitude: Faker::Address.longitude,
  latitude: Faker::Address.latitude,
  address: Faker::Address.street_address,
  city: Faker::Address.city,
  state: Faker::Address.state,
  country: Faker::Address.country
)

listing = Listing.new(
  user: proprietor,
  title: "Golden Heights Apartments",
  description: "Nestled within a peaceful neighborhood, this charming residential building exudes a warm and inviting ambiance,
                offering a comfortable and homely retreat for its residents",
  size: Faker::Number.between(from: 1, to: 500),
  floor_count: Faker::Number.between(from: 1, to: 50),
  metadata: "Also offers gym access and on-site car parking.",
  site_link: "https://example.com",
  listing_type: 0,
  location: location
)

image_paths = ['spec/factories/media/images/listing-1.jpg', 'spec/factories/media/images/listing-2.jpg']
image_paths.each do |image_path|
  listing.images.attach(io: File.open(Rails.root.join(image_path)), filename: File.basename(image_path))
end
listing.save!

ListingAmenity.create!(
  listing: listing,
  title: "Security Cameras",
  description: Faker::Lorem.paragraph,
  metadata: "There are surveillance cameras also on all corridors, staircases & elevators.",
  is_available: true,
  listing_type: 1,
)

ListingAmenity.create!(
  listing: listing,
  title: "Gymnasium",
  description: Faker::Lorem.paragraph,
  metadata: "They have free & pro plans for 1 month & 3 months.",
  is_available: false,
  listing_type: 1,
)

ListingAmenity.create!(
  listing: listing,
  title: "Solar panels",
  description: Faker::Lorem.paragraph,
  metadata: "They support water heaters.",
  is_available: true,
  listing_type: 0,
)

puts "Successfully seeded data"
