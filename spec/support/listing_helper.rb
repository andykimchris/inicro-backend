# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module ListingHelpers
  def create_listing
    image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
    FactoryBot.create(:listing,
                      images: [fixture_file_upload(image_path, 'image/jpg')])
  end

  def build_listing
    image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
    FactoryBot.build(:listing,
                     images: [fixture_file_upload(image_path, 'image/jpg')])
  end
end
