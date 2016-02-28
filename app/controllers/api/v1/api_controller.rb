module Api::V1
  class ApiController < ApplicationController
    # Provide controllers access to methods such as
    # authenticate_user!, user_signed_in?, etc
    include DeviseTokenAuth::Concerns::SetUserByToken
    include CanCan::ControllerAdditions

    # Authenticate user or hub before allowing them to use the
    # API
    devise_token_auth_group :hub_or_user, contains: [:hub, :user]
    before_action :authenticate_hub_or_user!

    # Authorized access to each resource
    load_and_authorize_resource
  end
end
