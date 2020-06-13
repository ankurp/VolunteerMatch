class RegistrationsController < Devise::RegistrationsController
  def new
    super do |resource|
      resource.role = @signup_user.role if @signup_user.present?
    end
  end

  def create
    super
  end

  def update
    super
  end
end

