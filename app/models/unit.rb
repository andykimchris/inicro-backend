# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :listing
  belongs_to :user, optional: true

  has_one_attached :floorplan_image

  enum unit_type: { studio: 0, '1-bedroom': 1, '2-bedroom': 2, '3-bedroom': 3 }

  validates :amount, :unit_type, presence: true
end
