# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :listing, optional: true

  validates :name, :description, :address, :city, presence: true
end
