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
            key :'$ref', :Hub
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
        response 200 do
          key :description, 'Hub successfully added'
          schema do
            key :'$ref', :Hub
          end
        end
        response 421 do
          key :description, 'Validation error(s)'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
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
      end
      operation :patch do
        key :summary, 'Update an existing hub'
        key :description, 'Update an existing hub if user has access.'
        key :operationId, 'updateHub'
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
        response 200 do
          key :description, 'Hub successfully updated'
          schema do
            key :'$ref', :Hub
          end
        end
        response 421 do
          key :description, 'Validation error(s)'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
      operation :delete do
        key :summary, 'Delete an existing hub'
        key :description, 'Deletes an existing hub and all associated printers, jobs, sensors, and data. Requires admin priveleges.'
        key :operationId, 'deleteHub'
        key :tags, [
          'Hub Management'
        ]
        response 204 do
          key :description, 'Hub successfully deleted'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
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
            key :'$ref', :Sensor
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
        key :summary, 'Add new sensor to hub'
        key :description, 'Add a new sensor to the hub if user has access.'
        key :operationId, 'addSensorToHub'
        key :tags, [
          'Hub Management', 'Sensor Management'
        ]
        parameter do
          key :name, :sensor
          key :in, :body
          key :description, 'Sensor object'
          key :required, true
          schema do
            key :'$ref', :Sensor
          end
        end
        response 200 do
          key :description, 'Sensor successfully added to hub'
          schema do
            key :'$ref', :Sensor
          end
        end
        response 421 do
          key :description, 'Validation error(s)'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
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
            key :'$ref', :Printer
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
        key :summary, 'Add new printer to hub'
        key :description, 'Add a new printer to the hub if user has access.'
        key :operationId, 'addPrinterToHub'
        key :tags, [
          'Hub Management', 'Printer Management'
        ]
        parameter do
          key :name, :printer
          key :in, :body
          key :description, 'Printer object'
          key :required, true
          schema do
            key :'$ref', :Printer
          end
        end
        response 200 do
          key :description, 'Printer successfully added to hub'
          schema do
            key :'$ref', :Printer
          end
        end
        response 421 do
          key :description, 'Validation error(s)'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
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
        response 201 do
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
      params.fetch(:hub, {}).permit(:friendly_id, :ip, :hostname, :location, :desc, :status)
    end
  end
end
