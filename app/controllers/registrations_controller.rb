class RegistrationsController < Devise::RegistrationsController
  def new
    @user = if @user.present?
      build_resource(@user.attributes)
    else
      build_resource
    end
    yield resource if block_given?
    respond_with resource
  end

  def create
    super
  end

  def update
    super
  end
end

