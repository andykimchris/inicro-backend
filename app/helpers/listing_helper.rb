# frozen_string_literal: true

module ListingHelper
  def lising_image_urls(listing)
    images_urls = listing.images.map { |image| url_for(image) } if listing.images.attached?

    { images_urls: }
  end
end
