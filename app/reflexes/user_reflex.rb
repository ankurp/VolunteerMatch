# frozen_string_literal: true

class UserReflex < ApplicationReflex
  def toggle_role
    @signup_user = User.new(role: element.dataset[:value])
  end

  def toggle_like
    user = User.find(element.dataset[:userid])
    likable_type = element.dataset[:likabletype]
    likable_id = element.dataset[:likableid]
    likable = likable_type.constantize.find(likable_id)
    like = likable.liked_by_user?(user)
    if like.present?
      like.destroy
    else
      like = Like.create(
        likable_type: likable_type,
        likable_id: likable_id,
        user_id: user.id
      )
    end
  end
end
