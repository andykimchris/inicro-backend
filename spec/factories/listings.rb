# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    title { 'Listing A' }
    description { 'Lorem Ipsum' }
    size { 10 }
    metadata { 'Extra details about the listing' }
    floor_count { 3 }
    listing_type { 0 }
    location { association(:location) }
    user { association(:proprietor_user) }

    after(:create) do |listing|
      image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
      listing.images.attach(io: Rails.public_path.join(image_path).open, filename: 'listing-1.jpg',
                            content_type: 'image/jpg')
    end
  end
end
