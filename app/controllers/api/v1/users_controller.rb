module Api::V1
  class UsersController < ApiController
    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/auth' do
      operation :post do
        key :summary, 'Register new user'
        key :description, 'Requires email, password, and password_confirmation params. A verification email will be sent to the email address provided.'
        key :operationId, 'registerNewUser'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :email
          key :in, :body
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password
          key :in, :body
          key :description, 'Password of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password_confirmation
          key :in, :body
          key :description, 'Password confirmation'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'User successfully registered'
        end
      end
    end
    swagger_path '/auth' do
      operation :patch do
        key :summary, 'Update existing user'
        key :description, 'This route will update an existing user\'s account settings. The default accepted params are password and password_confirmation.'
        key :operationId, 'updateUserAccount'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'User Authentication'
        ]
        parameter do
          key :name, :password
          key :in, :body
          key :description, 'Password of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password_confirmation
          key :in, :body
          key :description, 'Password confirmation'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'User successfully updated'
        end
      end
    end
    swagger_path '/auth/sign_in' do
      operation :post do
        key :summary, 'Sign in user'
        key :in, :body
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
          key :in, :body
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password
          key :in, :body
          key :description, 'Password of the user'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'User successfully logged in'
        end
        response 401 do
          key :description, 'Not authorized'
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
        response 201 do
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
          key :in, :body
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :client
          key :in, :body
          key :description, 'Session ID'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :'access-token'
          key :in, :body
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
          key :in, :body
          key :description, 'E-mail address of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :redirect_url
          key :in, :body
          key :description, 'The url to which the user will be redirected after visiting the link contained in the email'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'Password reset e-mail sent'
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
          key :in, :body
          key :description, 'Password of the user'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :password_confirmation
          key :in, :body
          key :description, 'Password confirmation'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'Password changed'
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
      params.require(:user).permit(:name, :email)
    end
  end
end
