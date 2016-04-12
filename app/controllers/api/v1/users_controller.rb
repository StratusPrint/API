module Api::V1
  class UsersController < ApiController
    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/auth' do
      operation :post do
        key :summary, 'Register new user'
        key :description, 'Requires email and confirm_success_url params. Valid user model params (e.g. name, image, etc.) are also accepted. A confirmation email will be sent to the email address provided with a randomly generated password. Once the account is confirmed, the user will be able to login. Note that the action of creating a new account requires admin priveleges.'
        key :operationId, 'registerNewUser'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :email
          key :in, :query
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :confirm_success_url
          key :in, :query
          key :description, 'Where to redirect user after successful e-mail confirmation'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'User successfully registered'
          schema do
            key :'$ref', :Hub
          end
        end
      end
    end
    swagger_path '/auth' do
      operation :patch do
        key :summary, 'Update existing user'
        key :description, 'This route will update an existing user\'s profile. The default accepted params are all valid user model params including password and password_confirmation.'
        key :operationId, 'updateUserAccount'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :password
          key :in, :query
          key :description, 'Password of the user'
          key :required, :false
          key :type, :string
        end
        parameter do
          key :name, :password_confirmation
          key :in, :query
          key :description, 'Password confirmation (required if password param provided)'
          key :required, :false
          key :type, :string
        end
        parameter do
          key :name, :name
          key :in, :query
          key :description, 'The name of the user'
          key :required, :false
          key :type, :string
        end
        parameter do
          key :name, :email
          key :in, :query
          key :description, 'The email of the user'
          key :required, :false
          key :type, :string
        end
        response 200 do
          key :description, 'User successfully updated'
          schema do
            key :'$ref', :Hub
          end
        end
      end
    end
    swagger_path '/auth/sign_in' do
      operation :post do
        key :summary, 'Sign in user'
        key :description, 'Requires email and password as params. This route will return a JSON representation of the User model on successful login along with the access-token and client in the header of the response.'
        key :operationId, 'signInUser'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :email
          key :in, :query
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password
          key :in, :query
          key :description, 'Password of the user'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'User successfully logged in'
          header 'access-token' do
            key :description, 'The access token header to use for the next authenticated request. Note that this access token is regenerated after each request for security purposes.'
            key :type, :string
          end
          header 'token-type' do
            key :description, 'The token type header to use for authenticated requests'
            key :type, :string
          end
          header 'uid' do
            key :description, 'The uid header to use for authenticated requests'
            key :type, :string
          end
          header 'client' do
            key :description, 'The client header to use for authenticated requests'
            key :type, :string
          end
          header 'expiry' do
            key :description, 'When the access token expires'
            key :type, :string
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
      end
    end
    swagger_path '/auth/sign_out' do
      operation :delete do
        key :summary, 'Sign out user'
        key :description, 'Use this route to end the user\'s current session. This route will invalidate the user\'s access token.'
        key :operationId, 'signOutUser'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        response 200 do
          key :description, 'User successfully logged out'
        end
      end
    end
    swagger_path '/auth/validate_token' do
      operation :get do
        key :summary, 'Validate access token'
        key :description, 'Use this route to validate tokens on return visits to the client. Requires uid, client, and access-token as params.'
        key :operationId, 'validateToken'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :uid
          key :in, :query
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :client
          key :in, :query
          key :description, 'Session ID'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :'access-token'
          key :in, :query
          key :description, 'Access token'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'Token valid'
        end
        response 401 do
          key :description, 'Token invalid'
        end
      end
    end
    swagger_path '/auth/password' do
      operation :post do
        key :summary, 'Send password reset e-mail'
        key :description, 'Use this route to send a password reset confirmation email to users that registered by email. Accepts email and redirect_url as params. The user matching the email param will be sent instructions on how to reset their password. redirect_url is the url to which the user will be redirected after visiting the link contained in the email.'
        key :operationId, 'resetPassword'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :uid
          key :in, :query
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :redirect_url
          key :in, :query
          key :description, 'The url to which the user will be redirected after visiting the link contained in the email'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'Password reset e-mail sent'
        end
        response 401 do
          key :description, 'Authorization error'
        end
      end
      operation :patch do
        key :summary, 'Change user password'
        key :description, 'Use this route to change users\' passwords. Requires password and password_confirmation as params.'
        key :operationId, 'changePassword'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :password
          key :in, :query
          key :description, 'Password of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password_confirmation
          key :in, :query
          key :description, 'Password confirmation'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'Password changed'
        end
        response 401 do
          key :description, 'Authorization error'
        end
      end
    end
    swagger_path '/users' do
      operation :get do
        key :summary, 'List all users'
        key :description, 'Use this route to list all registered users. Required admin priveleges.'
        key :operationId, 'listUsers'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Management'
        ]
        response 200 do
          key :description, 'List of users'
          schema do
            key :'$ref', :User
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
    end
    swagger_path '/users/{id}' do
      operation :get do
        key :summary, 'Find user by ID'
        key :description, 'Fetch a single user. Requires admin priveleges.'
        key :operationId, 'findUserById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Management'
        ]
        response 200 do
          key :description, 'User object'
          schema do
            key :'$ref', :User
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
      operation :patch do
        key :summary, 'Update an existing user'
        key :description, 'Accepts valid user model params. Requires admin priveleges.'
        key :operationId, 'updateUserById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Management'
        ]
        parameter do
          key :name, :email
          key :in, :query
          key :description, 'E-mail address of the user'
          key :required, :false
          key :type, :string
        end
        parameter do
          key :name, :name
          key :in, :query
          key :description, 'Name of the user'
          key :required, :false
          key :type, :string
        end
        parameter do
          key :name, :image
          key :in, :query
          key :description, 'The profile image URL of the user'
          key :required, :false
          key :type, :string
        end
        parameter do
          key :name, :admin
          key :in, :query
          key :description, 'Whether the user has admin priveleges or not'
          key :required, :false
          key :type, :boolean
        end
        response 200 do
          key :description, 'User object'
          schema do
            key :'$ref', :User
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
      operation :delete do
        key :summary, 'Delete an existing user'
        key :description, 'Deletes a user account. Requires admin priveleges.'
        key :operationId, 'deleteUser'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Management'
        ]
        response 204 do
          key :description, 'User successfully deleted'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
    end

    ###########################################################################
    # CONTROLLER ACTIONS
    ###########################################################################
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
      @users = User.all

      render json: @users
    end

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: url_for([:v1, @user])
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      # Ensure a user can't give themselves admin priveleges
      params.delete(:admin) if current_user.admin?
      params.require(:user).permit(:name, :email, :admin, :image)
    end
  end
end
