class Post < ApplicationRecord
  belongs_to :organization
  has_many :comments
  has_rich_text :content

  def lat_lng
    loc = self.organization.location
    {
      lat: loc.latitude,
      lng: loc.longitude
    }
  end

  def is_created_by?(user)
    return false if user.nil?
    user.organization.try(:id) == self.organization_id
  end
end
