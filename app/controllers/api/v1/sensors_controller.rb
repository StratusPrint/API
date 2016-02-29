module Api::V1
  class SensorsController < ApiController
    before_action :set_sensor, only: [:show, :update, :destroy]

    include DeviseTokenAuth::Concerns::SetUserByToken

    load_and_authorize_resource :hub
    load_and_authorize_resource :sensor, :through => :hub

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
        render json: @sensor, status: :created, location: @sensor
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
      params.fetch(:sensor, {})
    end
  end
end
