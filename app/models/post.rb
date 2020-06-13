class Post < ApplicationRecord
  belongs_to :organization
  has_many :comments
  has_rich_text :content

  def is_created_by?(user)
    user.organization.try(:id) == self.id
  end
end
