module Api::V1
  class ApiController < ApplicationController
    # Provide controllers access to methods such as
    # authenticate_user!, user_signed_in?, swagger_path, etc
    include Swagger::Blocks, CanCan::ControllerAdditions, DeviseTokenAuth::Concerns::SetUserByToken, ActionController::MimeResponds

    # Authenticate user or hub before allowing them to use the API
    devise_token_auth_group :hub_or_user, contains: [:hub, :user]
    before_action :authenticate_hub_or_user!

    # Authorized access to each resource
    load_and_authorize_resource

    # 403 response if access to resource not allowed
    rescue_from CanCan::AccessDenied do
      render :json => Errors::UnauthorizedAccessError, status: :forbidden
    end

    private
    def current_ability
      if user_signed_in?
        @current_ability ||= UserAbility.new(current_user)
      elsif hub_signed_in?
        @current_ability ||= HubAbility.new(current_hub)
      end
    end
  end
end
