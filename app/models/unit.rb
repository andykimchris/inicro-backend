# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :listing
  belongs_to :user, optional: true

  has_many :unit_wishlists # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :users, through: :unit_wishlists

  has_one_attached :floorplan_image
  has_one_attached :qrcode, dependent: :destroy
  has_many_attached :images

  enum unit_type: { studio: 0, '1-bedroom': 1, '2-bedroom': 2, '3-bedroom': 3 }
  enum unit_lease_type: { rental: 0, purchase: 1 }

  validates :amount, :unit_type, :unit_lease_type, presence: true
  validates :identifier, uniqueness: { scope: :listing_id }, if: -> { listing_id.present? }

  validates :floorplan_image,
            content_type: Constants::IMAGE_FORMATS,
            size: { less_than: 1.megabyte }

  validates :images,
            content_type: Constants::IMAGE_FORMATS,
            size: { less_than: 3.megabytes },
            length: { maximum: 5 }

  validate :user_is_occupant

  # TODO: Generate this ONLY when proprietor is giving access to a tenant
  before_commit :generate_qrcode, on: :create

  private

  def user_is_occupant
    return unless user&.is_proprietor?

    errors.add(:user, 'must be an occupant')
  end

  def assign_unit_to_user_path
    # TODO: Figure out what this POST path should do
    host = Rails.application.config.action_controller.default_url_options[:host]
    @assign_unit_to_user_path ||= "http://#{host}/unit/#{id}"
  end

  def generate_qrcode
    qr = RQRCode::QRCode.new(assign_unit_to_user_path)

    file = qr.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 240
    )

    qrcode.attach(
      io: StringIO.new(file.to_s),
      filename: 'qrcode.png', # TODO: Rename filename
      content_type: 'image/png'
    )
  end
end
