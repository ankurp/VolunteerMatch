class Comment < ApplicationRecord
  include CableReady::Broadcaster

  belongs_to :post
  belongs_to :user

  after_create :notify_organizer_and_broadcast

  def notify_organizer_and_broadcast
    Notification.post(to: self.post.created_by, from: self.user, action: :post_comment, notifiable: self)
    cable_ready['comment'].insert_adjacent_html(
      selector: '.new-comment-placeholder',
      position: 'afterbegin',
      html: ApplicationController.render(
        partial: "comments/comment",
        locals: { comment: self }
      )
    )
    cable_ready.broadcast
  end
end
