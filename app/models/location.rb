# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :listings, dependent: :restrict_with_error

  validates :name, :description, :address, :city, presence: true
end
