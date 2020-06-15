class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :notify_organizer

  def notify_organizer
    Notification.post(to: self.post.created_by, from: self.user, action: :post_comment, notifiable: self)
  end
end
