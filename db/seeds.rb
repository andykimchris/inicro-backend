require "faker"

# Proprietor
proprietor = User.create!(email: "andrew.muchiri97@gmail.com",
            password: "Johndoe123!", password_confirmation: 'Johndoe123!',
            is_occupant: false, is_proprietor: true,
            confirmed_at: Time.now.utc)

# Occupants
User.create!(email: Faker::Internet.email,
            password: "Johndoe123!", password_confirmation: 'Johndoe123!',
            is_occupant: true, is_proprietor: false,
            confirmed_at: Time.now.utc)

User.create!(email: Faker::Internet.email,
            password: "Janedoe123!", password_confirmation: 'Janedoe123!',
            is_occupant: true, is_proprietor: false,
            confirmed_at: Time.now.utc)

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

listing = Listing.create!(
  user: proprietor,
  title: "Golden Heights Apartments",
  description: "Nestled within a peaceful neighborhood, this charming residential building exudes a warm and inviting ambiance,
                offering a comfortable and homely retreat for its residents",
  size: Faker::Number.between(from: 1, to: 500),
  floor_count: Faker::Number.between(from: 1, to: 50),
  metadata: "Also offers gym access and on-site car parking.",
  site_link: "https://example.com",
  listing_type: 0,
  location_id: location.id
)

ListingAmenity.create!(
  listing: listing,
  onsite_parking: true,
  gymnasium: false,
  elevator: true,
  security_cameras: false,
  wheelchair_accessible: true,
  generator: true,
  borehole: false
)

puts "Created test data succesfully..."
