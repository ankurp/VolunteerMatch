class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :name,
        :email,
        :password,
        :password_confirmation,
        :role, 
        location_attributes: [
          :street_address, 
          :city, 
          :state,
          organization_attributes: [
            :name
          ]
        ]
      ])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def is_organizer!
      raise ActionController::BadRequest.new('Not Authorized') unless current_user.organizer?
    end
end
