# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :user, class_name: 'User', primary_key: 'id', inverse_of: :listings
  has_one :location, dependent: :destroy

  enum type: { residential: 0, commercial: 1, land: 2 }

  validates :title, :description, presence: true
end
