class Post < ApplicationRecord
  belongs_to :organization
  has_many :comments
  has_rich_text :text
end
