# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :listings, dependent: :nullify

  validates :name, :description, :address, :city, presence: true
end
