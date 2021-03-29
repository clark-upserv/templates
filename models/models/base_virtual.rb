# frozen_string_literal: true

# mimick rails models but that do not require a database table
class VirtualModel
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

#  def assign_attributes(attributes = {})
#    attributes.each do |name, value|
#      send("#{name}=", value)
#    end
#  end

  def persisted?
    false
  end
end
