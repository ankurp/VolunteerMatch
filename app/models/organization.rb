class Organization < ApplicationRecord
  has_one :location, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one_attached :logo, dependent: :destroy

  delegate :address, to: :location
  delegate :has_coordinates?, to: :location

  accepts_nested_attributes_for :location
end
