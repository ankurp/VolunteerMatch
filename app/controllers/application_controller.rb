require 'jwt'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!

  def map_token
    payload = {
      iss: Rails.application.credentials.dig(:map, :team_id),
      iat: Time.now.to_i,
      exp: Time.now.to_i + 30.minutes.to_i,
    };

    p_key = OpenSSL::PKey::EC.new Rails.application.credentials.dig(:map, :key)
    token = JWT.encode payload, p_key, 'ES256', {
      kid: Rails.application.credentials.dig(:map, :key_id),
      typ: 'JWT'
    }
    render json: token
  end

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
            :name,
            :logo
          ]
        ]
      ])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def is_organizer!
      raise ActionController::BadRequest.new('Not Authorized') unless current_user.organizer?
    end
end
