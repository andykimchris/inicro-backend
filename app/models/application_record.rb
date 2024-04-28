# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :by_id, ->(value) { where(id: value) }
  scope :ordered, ->(order = :asc) { order(created_at: order).order(:id) }
end
