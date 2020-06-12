# frozen_string_literal: true

class UserReflex < ApplicationReflex
  def toggle_user_type
    @user = User.new(user_type: element.dataset[:value])
  end
end
