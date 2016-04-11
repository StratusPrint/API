module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_filter :authorize_admin, only: :create

    private

    def authorize_admin
      return unless !user_signed_in? or !current_user.admin?
      render :json => Errors::UnauthorizedAccessError, status: :forbidden
    end
  end
end
