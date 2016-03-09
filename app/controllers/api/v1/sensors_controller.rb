module Api::V1
  class SensorsController < ApiController
    ###########################################################################
    # AUTHORIZATION
    ###########################################################################
    load_and_authorize_resource :hub
    load_and_authorize_resource :sensor, :through => :hub

    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/sensors/{id}' do
      operation :get do
        key :summary, 'Find sensor by ID'
        key :description, 'Fetches a single sensor if user has access.'
        key :operationId, 'findSensorById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the sensor'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'Sensor object'
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
      operation :patch do
        key :summary, 'Update sensor by ID'
        key :description, 'Update the specified sensor if user has access.'
        key :operationId, 'updateSensor'
        key :tags, [
          'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the sensor'
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
        response 200 do
          key :description, 'Sensor successfully updated'
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
      operation :delete do
        key :summary, 'Delete an existing sensor'
        key :description, 'Deletes an existing sensor and all associated data.'
        key :operationId, 'deleteSensor'
        key :tags, [
          'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the sensor'
          key :required, :true
          key :type, :integer
        end
        response 204 do
          key :description, 'Sensor successfully deleted'
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
      end
    end

    swagger_path '/sensors/{id}/data' do
      operation :get do
        key :summary, 'List all data collected by a sensor'
        key :description, 'Fetches the logged data associated with the given sensor. Note that user must have access the parent sensor to carry out this action.'
        key :operationId, 'findSensorDataById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the sensor'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'Sensor data'
          schema do
            key :'$ref', :DataPoint
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
        key :summary, 'Add data entry to sensor'
        key :description, 'Add a single data entry to specified sensor if user has access.'
        key :operationId, 'addSensorData'
        key :tags, [
          'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the sensor'
          key :required, :true
          key :type, :integer
        end
        parameter do
          key :name, :data_point
          key :in, :body
          key :description, 'Data object'
          key :required, true
          schema do
            key :'$ref', :DataPoint
          end
        end
        response 200 do
          key :description, 'Data successfully added to sensor'
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

    ###########################################################################
    # CONTROLLER ACTIONS
    ###########################################################################
    before_action :set_sensor, only: [:show, :update, :destroy]

    # GET /sensors
    def index
      @sensors = Hub.find_by(id: params[:hub_id]).sensors

      render json: @sensors
    end

    # GET /sensors/1
    def show
      render json: @sensor
    end

    # POST /sensors
    def create
      @sensor = Sensor.new(sensor_params)
      if @sensor.save
        Hub.find_by(id: params[:hub_id]).sensors << @sensor
        render json: @sensor, status: :created, location: v1_sensor_path(@sensor)
      else
        render json: @sensor.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /sensors/1
    def update
      if @sensor.update(sensor_params)
        render json: @sensor
      else
        render json: @sensor.errors, status: :unprocessable_entity
      end
    end

    # DELETE /sensors/1
    def destroy
      @sensor.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sensor_params
      params.fetch(:sensor, {}).permit(:friendly_id, :category, :manufacturer, :model, :desc, :data_count)
    end
  end
end
