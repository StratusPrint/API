module Api::V1
  class HubsController < ApiController
    before_action :set_hub, only: [:show, :update, :destroy]

    include Swagger::Blocks

    swagger_path '/hubs' do
      operation :get do
        key :description, 'Fetches a list of all hubs if user has access'
        key :operationId, 'findHubs'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hubs'
        ]
        response 200 do
          key :description, 'hub response'
          schema do
            key :'$ref', :Hub
          end
        end
      end
    end

    swagger_path '/hubs/{id}' do
      operation :get do
        key :description, 'Fetches a single hub if user has access'
        key :operationId, 'findHubById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hubs'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'hub response'
          schema do
            key :'$ref', :Hub
          end
        end
      end
    end

    swagger_path '/hubs/{id}/sensors' do
      operation :get do
        key :description, 'Fetches a list of sensors managed by the given hub'
        key :operationId, 'findHubSensors'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hubs', 'Sensors'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'sensor response'
          schema do
            key :'$ref', :Sensor
          end
        end
      end
    end

    swagger_path '/hubs/{id}/printers' do
      operation :get do
        key :description, 'Fetches a list of printers managed by the given hub'
        key :operationId, 'findHubPrinters'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Hubs', 'Printers'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the hub'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'printer response'
          schema do
            key :'$ref', :Printer
          end
        end
      end
    end

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
        render json: @hub, status: :created, location: @hub
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
      params.fetch(:hub, {})
    end
  end
end
