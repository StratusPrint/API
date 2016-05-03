module Api::V1
  class DataPointsController < ApiController
    ###########################################################################
    # AUTHORIZATION
    ###########################################################################
    load_and_authorize_resource :sensor
    load_and_authorize_resource :data_point, :through => :sensor

    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/data/{id}' do
      operation :get do
        key :summary, 'Find data entry by ID'
        key :description, 'Fetches a single data entry logged by a sensor. Note that user must have access the parent sensor to carry out this action.'
        key :operationId, 'findDataById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Sensor Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the data entry'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'data response'
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
        response 404 do
          key :description, 'Data entry not found'
        end
      end
    end

    ###########################################################################
    # CONTROLLER ACTIONS
    ###########################################################################
    before_action :set_data_point, only: [:show, :update, :destroy]
    has_scope :days_ago
    has_scope :hours_ago

    # GET /data_points
    def index
      @data_points = Sensor.find_by(id: params[:sensor_id]).data_points
      @data_points = @data_points & apply_scopes(DataPoint).all
      render json: @data_points
    end

    # GET /data_points/1
    def show
      render json: @data_point
    end

    # POST /data_points
    def create
      @data_point = DataPoint.new(data_point_params)

      if @data_point.save
        @sensor = Sensor.find_by(id: params[:sensor_id])
        @sensor.data_points << @data_point

        if @data_point.violates_threshold? and !@sensor.alert_generated?
          @sensor.alert_generated = true
          @sensor.save
          create_alert
        elsif @data_point.is_normal? and @sensor.alert_generated?
          @sensor.alert_generated = false
          @sensor.save
          create_alert
        end

        render json: @data_point, status: :created, location: v1_datum_path(@data_point)
      else
        render json: @data_point.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /data_points/1
    def update
      if @data_point.update(data_point_params)
        render json: @data_point
      else
        render json: @data_point.errors, status: :unprocessable_entity
      end
    end

    # DELETE /data_points/1
    def destroy
      @data_point.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_point
      @data_point = DataPoint.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def data_point_params
      params.fetch(:data_point, {}).permit(:value)
    end

    # Create an alert if new data point violates a sensor threshold
    def create_alert
      CreateAlertJob.perform_later(@data_point.sensor, @data_point)
    end
  end
end
