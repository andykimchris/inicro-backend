# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    title { 'Golden Heights Apartments' }
    description do
      "Nestled within a peaceful neighborhood, this charming residential building exudes a warm and inviting ambiance,
    offering a comfortable and homely retreat for its residents"
    end
    size { 10 }
    metadata { 'Also offers gym access and on-site car parking.' }
    floor_count { 3 }
    listing_type { 0 }
    location { association(:location) }
    user { association(:proprietor_user) }

    after(:build) do |listing|
      image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
      listing.images.attach(io: Rails.public_path.join(image_path).open, filename: 'listing-1.jpg',
                            content_type: 'image/jpg')
    end
  end
end
