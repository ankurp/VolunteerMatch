class Location < ApplicationRecord
  belongs_to :organization
  has_one :user
  delegate :posts, to: :organization

  accepts_nested_attributes_for :organization

  geocoded_by :address
  before_save :geocode, if: ->(obj){ obj.address_changed? }

  def address_changed?
    street_address_changed? || city_changed? || state_changed?
  end

  def address
    [street_address, city, state, 'United States'].compact.join(', ')
  end

  def short_address
    [city, state].compact.join(', ')
  end

  def has_coordinates?
    self.latitude.present? && self.longitude.present?
  end

  def valid?(*args)
    return true
  end
end
