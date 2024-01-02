# frozen_string_literal: true

class UnitBlueprint < Blueprinter::Base
  identifier :id

  fields :size, :amount, :description, :identifier, :is_available, :availability_date
end
