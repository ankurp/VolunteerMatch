# frozen_string_literal: true

class UserReflex < ApplicationReflex
  def toggle_role
    @signup_user = User.new(role: element.dataset[:value])
  end
end
