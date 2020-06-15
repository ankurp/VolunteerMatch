class Like < ActiveRecord::Base
  belongs_to :user

  after_create :notify_organizer

  def notify_organizer
    Notification.post(to: likable.created_by, from: self.user, action: :like, notifiable: self)
  end

  def likable
    @likable ||= likable_type.constantize.find(likable_id)
  end
end
