# frozen_string_literal: true

class UnitBlueprint < Blueprinter::Base
  identifier :id

  fields :listing_id, :size, :amount, :description, :identifier, :is_available, :availability_date, :unit_type,
         :unit_lease_type
end
