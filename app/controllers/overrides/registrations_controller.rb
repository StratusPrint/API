module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :authorize_admin, only: :create

    def sign_up_params
      password = generate_random_password
      params[:password] = password
      params[:password_confirmation] = password
      params.permit(*params_for_resource(:sign_up))
    end

    private

    def authorize_admin
      return unless !user_signed_in? or !current_user.admin?
      render :json => Errors::UnauthorizedAccessError, status: :forbidden
    end

    def generate_random_password
      password_length = 8
      password = Devise.friendly_token.first(password_length)
    end
  end
end
