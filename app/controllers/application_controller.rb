class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  # "Whitelist" additional user parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :image, :default_hub_id])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :image, :admin, :default_hub_id])
  end
end
