# frozen_string_literal: true

class UnitWishlist < ApplicationRecord
  belongs_to :user
  belongs_to :unit
end
