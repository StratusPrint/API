module Api::V1
  class ApiController < ApplicationController
    # Provide controllers access to methods such as
    # authenticate_user!, user_signed_in?, etc
    include DeviseTokenAuth::Concerns::SetUserByToken

    # Authenticate user before allowing them to use the
    # API
    before_action :authenticate_user!
  end
end
