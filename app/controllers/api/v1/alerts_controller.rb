module Api::V1
  class AlertsController < ApiController
    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/alerts' do
      operation :get do
        key :summary, 'List all alerts'
        key :description, 'Use this route to list all alerts that have been generated. Each alert represents a specific event that would be important for an end user to know.'
        key :operationId, 'listAlerts'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Alert Management'
        ]
        response 200 do
          key :description, 'List of alerts'
          schema do
            key :'$ref', :Alert
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
    swagger_path '/alerts/{id}' do
      operation :get do
        key :summary, 'Find alert by ID'
        key :description, 'Use this route to retrieve a specific alert.'
        key :operationId, 'findAlertById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Alert Management'
        ]
        response 200 do
          key :description, 'Alert object'
          schema do
            key :'$ref', :Alert
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
    ###########################################################################
    # CONTROLLER ACTIONS
    ###########################################################################
    before_action :set_alert, only: [:show, :update, :destroy]

    # GET /alerts
    def index
      @alerts = Alert.all

      render json: @alerts
    end

    # GET /alerts/1
    def show
      render json: @alert
    end

    # POST /alerts
    def create
      @alert = Alert.new(alert_params)

      if @alert.save
        render json: @alert, status: :created, location: @alert
      else
        render json: @alert.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /alerts/1
    def update
      if @alert.update(alert_params)
        render json: @alert
      else
        render json: @alert.errors, status: :unprocessable_entity
      end
    end

    # DELETE /alerts/1
    def destroy
      @alert.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.fetch(:alert, {})
    end
  end
end
