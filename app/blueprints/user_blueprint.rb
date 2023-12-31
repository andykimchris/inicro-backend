# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :is_proprietor, :is_occupant
end
