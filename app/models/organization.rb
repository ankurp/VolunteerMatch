class Organization < ApplicationRecord
  has_many :locations
  has_many :posts
  has_one_attached :logo
end
