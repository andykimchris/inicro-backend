# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :uuid

  fields :email, :is_proprietor, :is_occupant
end
