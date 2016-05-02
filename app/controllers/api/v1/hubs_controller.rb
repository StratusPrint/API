module Api::V1
  class HubsController < ApiController
    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/hubs' do
      operation :get do
        key :summary, 'List all hubs'
        key :description, 'Fetch a list of all hubs if user has access.'
        key :operationId, 'findHubs'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Management',
        ]
        response 200 do
          key :description, 'List of hubs'
          schema do
            key :type, :array
            items do
              key :'$ref', :Hub
            end
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
      operation :post do
        key :summary, 'Add new hub'
        key :description, 'Add a new hub if user has access.'
        key :operationId, 'addHub'
        key :tags, [
          'Hub Management'
        ]
        parameter do
          key :name, :hub
          key :in, :body
          key :description, 'Hub object'
          key :required, true
          schema do
            key :'$ref', :Hub
          end
        end
        response 201 do
          key :description, 'Hub successfully created'
          schema do
            key :'$ref', :Hub
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 422 do
          key :description, 'Validation error(s) - see response for details'
        end
      end
    end
    swagger_path '/hubs/{id}' do
      operation :get do
        key :summary, 'Find hub by ID'
        key :description, 'Fetch a single hub if user has access.'
        key :operationId, 'findHubById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'Hub object'
          schema do
            key :'$ref', :Hub
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
      end
      operation :patch do
        key :summary, 'Update an existing hub'
        key :description, 'Update an existing hub if user has access.'
        key :operationId, 'updateHub'
        key :tags, [
          'Hub Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        parameter do
          key :name, :hub
          key :in, :body
          key :description, 'Hub object'
          key :required, true
          schema do
            key :'$ref', :Hub
          end
        end
        response 200 do
          key :description, 'Hub successfully updated'
          schema do
            key :'$ref', :Hub
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
        response 422 do
          key :description, 'Validation error(s) - see response for details'
        end
      end
      operation :delete do
        key :summary, 'Delete an existing hub'
        key :description, 'Deletes an existing hub and all associated printers, jobs, sensors, and data. Requires admin priveleges.'
        key :operationId, 'deleteHub'
        key :tags, [
          'Hub Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 204 do
          key :description, 'Hub successfully deleted'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
      end
    end
    swagger_path '/hubs/{id}/api_key' do
      operation :post do
        key :summary, 'Generate new API key'
        key :description, 'Generates a new API key that can be used by the hub to authenticate with the API. The new API key that is generated will replace any pre-existing key. The API key is returned in plaintext in the response, after which it cannot be retrieved again. If a hub API key is forgotten, then it must be regenerated using this endpoint. Requires admin priveleges.'
        key :operationId, 'generateHubApiKey'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'API key successfully generated'
          schema do
            property :api_key do
              key :name, :api_key
              key :description, 'The API key that the hub can use for authentication'
              key :type, :string
            end
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
      end
    end
    swagger_path '/hubs/{id}/statistics' do
      operation :get do
        key :summary, 'List hub statistics'
        key :description, 'Fetch a list of useful statistics about the printers connected to the given hub.'
        key :operationId, 'findHubStatistics'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'A list of sensors'
          schema do
            property :jobs_in_progress do
              key :name, :jobs_in_progress
              key :description, 'The number of jobs currently in progress'
              key :type, :integer
            end
            property :queued_jobs do
              key :name, :queued_jobs
              key :description, 'The number of jobs queued and waiting to be printed'
              key :type, :integer
            end
            property :processing_jobs do
              key :name, :processing_jobs
              key :description, 'The number of jobs processing that have not yet been queued or sent to a printer'
              key :type, :integer
            end
            property :current_wait_time do
              key :name, :current_wait_time
              key :description, 'The estimated amount of time (in seconds) until a printer is ready for to begin another job. This value will be zero if there are one or more printers that are currently ready to begin a print job'
              key :type, :integer
            end
            property :current_wait_time do
              key :name, :current_wait_time
              key :description, 'The estimated amount of time (in seconds) until a printer is ready for another job. This value will be zero if there are printers that are currently ready for a new print job'
              key :type, :integer
            end
            property :ready_printers do
              key :name, :ready_printers
              key :description, 'The number of printers that are ready for a new print job'
              key :type, :integer
            end
            property :busy_printers do
              key :name, :busy_printers
              key :description, 'The number of printers that are currently busy'
              key :type, :integer
            end
            property :errored_printers do
              key :name, :errored_printers
              key :description, 'The number of printers that are in the errored state'
              key :type, :integer
            end
            property :completed_printers do
              key :name, :completed_printers
              key :description, 'The number of printers that are in the completed state'
              key :type, :integer
            end
            property :paused_printers do
              key :name, :paused_printers
              key :description, 'The number of printers that are in the paused state'
              key :type, :integer
            end
            property :printing_printers do
              key :name, :printing_printers
              key :description, 'The number of printers that are in the printing state'
              key :type, :integer
            end
            property :offline_printers do
              key :name, :offline_printers
              key :description, 'The number of printers that are in the offline state'
              key :type, :integer
            end
            property :cancelled_printers do
              key :name, :cancelled_printers
              key :description, 'The number of printers that are in the cancelled state'
              key :type, :integer
            end
            property :attached_printers do
              key :name, :attached_printers
              key :description, 'The number of printers attached to the hub'
              key :type, :integer
            end
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
      end
    end
    swagger_path '/hubs/{id}/sensors' do
      operation :get do
        key :summary, 'List all sensors managed by a hub'
        key :description, 'Fetch a list of sensors managed by the given hub. Note that the user must have access the parent hub to carry out this action.'
        key :operationId, 'findHubSensors'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Management', 'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'A list of sensors'
          schema do
            key :type, :array
            items do
              key :'$ref', :Sensor
            end
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
      end
      operation :post do
        key :summary, 'Add new sensor to hub'
        key :description, 'Add a new sensor to the hub if user has access.'
        key :operationId, 'addSensorToHub'
        key :tags, [
          'Hub Management', 'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        parameter do
          key :name, :sensor
          key :in, :body
          key :description, 'Sensor object'
          key :required, true
          schema do
            key :'$ref', :Sensor
          end
        end
        response 201 do
          key :description, 'Sensor successfully added to hub'
          schema do
            key :'$ref', :Sensor
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
        response 422 do
          key :description, 'Validation error(s) - see response for details'
        end
      end
    end
    swagger_path '/hubs/{id}/printers' do
      operation :get do
        key :summary, 'List all printers managed by a hub'
        key :description, 'Fetch a list of printers managed by the given hub. Note that user must have access to the parent hub to carry out this action.'
        key :operationId, 'findHubPrinters'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Management', 'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'A list of printers'
          schema do
            key :type, :array
            items do
              key :'$ref', :Printer
            end
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
      end
      operation :post do
        key :summary, 'Add new printer to hub'
        key :description, 'Add a new printer to the hub if user has access.'
        key :operationId, 'addPrinterToHub'
        key :tags, [
          'Hub Management', 'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        parameter do
          key :name, :printer
          key :in, :body
          key :description, 'Printer object'
          key :required, true
          schema do
            key :'$ref', :Printer
          end
        end
        response 201 do
          key :description, 'Printer successfully added to hub'
          schema do
            key :'$ref', :Printer
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Hub not found'
        end
        response 422 do
          key :description, 'Validation error(s) - see response for details'
        end
      end
    end
    swagger_path '/hub_auth/sign_in' do
      operation :post do
        key :summary, 'Sign in hub'
        key :description, 'Requires Authorization header with the hub\'s API key. This route will return a JSON representation of the Hub model on successful login along with the access-token, uid, and client in the header of the response. The access token expires every two weeks. Once logged in, the hub can begin logging sensor data, print jobs, and maintaining state of said objects.'
        key :operationId, 'signInHub'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Authentication'
        ]
        parameter do
          key :name, :Authorization
          key :in, :header
          key :description, 'API key of the hub'
          key :required, :true
          key :type, :string
        end
        response 200 do
          key :description, 'Hub successfully logged in'
          header 'access-token' do
            key :description, 'The access token header to use for authenticated requests. Note that this access token expires every two weeks or until the hub explicitly signs out.'
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
          schema do
            key :'$ref', :Hub
          end
        end
        response 401 do
          key :description, 'Not authorized'
        end
      end
    end
    swagger_path '/hub_auth/sign_out' do
      operation :delete do
        key :summary, 'Sign out hub'
        key :description, 'Use this route to end the hub\'s current session. This route will invalidate the hub\'s access token.'
        key :operationId, 'signOutHub'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Authentication'
        ]
        response 200 do
          key :description, 'Hub successfully logged out'
        end
      end
    end
    swagger_path '/hub_auth/validate_token' do
      operation :get do
        key :summary, 'Validate access token'
        key :description, 'Use this route to validate tokens on return visits to the client. Requires uid, client, and access-token as params.'
        key :operationId, 'validateHubToken'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hub Authentication'
        ]
        parameter do
          key :name, :uid
          key :in, :query
          key :description, 'Friendly ID of the hub'
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
          schema do
            key :'$ref', :Hub
          end
        end
        response 401 do
          key :description, 'Token invalid'
        end
      end
    end

    ###########################################################################
    # CONTROLLER ACTIONS
    ###########################################################################
    before_action :set_hub, only: [:show, :update, :destroy]

    # GET /hubs
    def index
      @hubs = Hub.all

      render json: @hubs
    end

    # GET /hubs/1/statistics
    def show_statistics
      render json: @hub, serializer: HubStatisticSerializer
    end

    # GET /hubs/1
    def show
      render json: @hub
    end

    # POST /hubs
    def create
      @hub = Hub.new(hub_params)

      if @hub.save
        render json: @hub, status: :created, location: v1_hub_path(@hub)
      else
        render json: @hub.errors, status: :unprocessable_entity
      end
    end

    # POST /hubs/1/api_key
    def generate_api_key
      api_key = @hub.generate_api_token
      resp = {
        :api_key => api_key
      }
      render json: resp
    end

    # PATCH/PUT /hubs/1
    def update
      if @hub.update(hub_params)
        render json: @hub
      else
        render json: @hub.errors, status: :unprocessable_entity
      end
    end

    # DELETE /hubs/1
    def destroy
      @hub.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_hub
      @hub = Hub.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hub_params
      params.fetch(:hub, {}).permit(:friendly_id, :ip, :port, :hostname, :location, :desc, :status)
    end
  end
end
