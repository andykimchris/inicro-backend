# frozen_string_literal: true

module UnitHelper
  def unit_image_urls(unit)
    floorplan_url = url_for(unit.floorplan_image) if unit.floorplan_image.attached?
    qrcode_url = url_for(unit.qrcode) if unit.qrcode.attached?
    images_urls = unit.images.map { |image| url_for(image) } if unit.images.attached?

    { floorplan_url:, qrcode_url:, images_urls: }
  end
end
