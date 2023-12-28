class UserBluePrint < Blueprinter::Base
  identifier :uuid

  fields :email, :is_proprietor, :is_occupant
end
