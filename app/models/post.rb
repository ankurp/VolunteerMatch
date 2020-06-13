class Post < ApplicationRecord
  belongs_to :organization
  has_many :comments
  has_rich_text :content

  def is_created_by?(user)
    return false if user.nil?
    user.organization.try(:id) == self.organization_id
  end
end
