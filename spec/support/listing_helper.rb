# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module ListingHelpers
  FactoryBot.create(:location)
  FactoryBot.create(:proprietor_user)
  def create_listing
    image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
    FactoryBot.create(:listing, title: 'Golden Heights', description: 'Lorem Ipsum is simply dummy', size: 10, floor_count: 3,
                                location:, user: proprietor_user,
                                images: [fixture_file_upload(image_path, 'image/jpg')])
  end

  def build_listing
    image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
    FactoryBot.create(:listing, title: 'Golden Heights', description: 'Lorem Ipsum is simply dummy', size: 10, floor_count: 3,
                                location:, user: proprietor_user, images: [fixture_file_upload(image_path, 'image/jpg')])
  end
end
