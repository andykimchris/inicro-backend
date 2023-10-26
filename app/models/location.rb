# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :listing

  validates :name, :description, :address, :city, presence: true
end
