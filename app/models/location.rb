class Location < ApplicationRecord
  belongs_to :organization

  accepts_nested_attributes_for :organization

  def valid?(*args)
    return true
  end
end
