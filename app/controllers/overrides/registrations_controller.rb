module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :authorize_admin, only: :create

    def sign_up_params
      password = generate_random_password
      params[:password] = password
      params[:password_confirmation] = password
      params.permit(*params_for_resource(:sign_up))
    end

    def create
      @resource            = resource_class.new(sign_up_params)
      @resource.provider   = "email"

      # password randomly generated for the user that will be sent
      # in the confirmation e-mail
      @password = params[:password]

      # honor devise configuration for case_insensitive_keys
      if resource_class.case_insensitive_keys.include?(:email)
        @resource.email = sign_up_params[:email].try :downcase
      else
        @resource.email = sign_up_params[:email]
      end

      # give redirect value from params priority
      @redirect_url = params[:confirm_success_url]

      # fall back to default value if provided
      @redirect_url ||= DeviseTokenAuth.default_confirm_success_url

      # success redirect url is required
      if resource_class.devise_modules.include?(:confirmable) && !@redirect_url
        return render_create_error_missing_confirm_success_url
      end

      # if whitelist is set, validate redirect_url against whitelist
      if DeviseTokenAuth.redirect_whitelist
        unless DeviseTokenAuth.redirect_whitelist.include?(@redirect_url)
          return render_create_error_redirect_url_not_allowed
        end
      end

      begin
        # override email confirmation, must be sent manually from ctrl
        resource_class.set_callback("create", :after, :send_on_create_confirmation_instructions)
        resource_class.skip_callback("create", :after, :send_on_create_confirmation_instructions)
        if @resource.save
          yield @resource if block_given?

          unless @resource.confirmed?
            # user will require email authentication
            @resource.send_confirmation_instructions({
                                                       client_config: params[:config_name],
                                                       redirect_url: @redirect_url,
                                                       password: @password
            })

          else
            # email auth has been bypassed, authenticate user
            @client_id = SecureRandom.urlsafe_base64(nil, false)
            @token     = SecureRandom.urlsafe_base64(nil, false)

            @resource.tokens[@client_id] = {
              token: BCrypt::Password.create(@token),
              expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
            }

            @resource.save!

            update_auth_header
          end
          render_create_success
        else
          clean_up_passwords @resource
          render_create_error
        end
      rescue ActiveRecord::RecordNotUnique
        clean_up_passwords @resource
        render_create_error_email_already_exists
      end
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
