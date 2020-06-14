class Organization < ApplicationRecord
  has_one :location
  has_many :posts
  has_one_attached :logo

  delegate :address, to: :location
  delegate :has_coordinates?, to: :location

  accepts_nested_attributes_for :location
end
