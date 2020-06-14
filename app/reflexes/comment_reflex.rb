# frozen_string_literal: true

class CommentReflex < ApplicationReflex
  def create(text, post_id, user_id)
    Comment.create(post_id: post_id, user_id: user_id, text: text)
  end
end
