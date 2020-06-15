class Post < ApplicationRecord
  include Hashid::Rails

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

  def created_by
    organization.location.user
  end

  def is_created_by?(user)
    return false if user.nil?
    user.organization.try(:id) == self.organization_id
  end

  def to_param
    self.hashid
  end

  def liked_by_user?(user)
    Like.where(likable_type: self.class.to_s, likable_id: self.id, user: user).first
  end

  def like_count
    Like.where(likable_type: self.class.to_s, likable_id: self.id).count
  end
end
