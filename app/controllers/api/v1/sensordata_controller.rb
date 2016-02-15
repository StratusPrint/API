module Api::V1
  class SensordataController < ApiController
    before_action :set_sensordatum, only: [:show, :update, :destroy]

    # GET /sensordata
    def index
      @sensordata = Sensordatum.all

      render json: @sensordata
    end

    # GET /sensordata/1
    def show
      render json: @sensordatum
    end

    # POST /sensordata
    def create
      @sensordatum = Sensordatum.new(sensordatum_params)

      if @sensordatum.save
        render json: @sensordatum, status: :created, location: @sensordatum
      else
        render json: @sensordatum.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /sensordata/1
    def update
      if @sensordatum.update(sensordatum_params)
        render json: @sensordatum
      else
        render json: @sensordatum.errors, status: :unprocessable_entity
      end
    end

    # DELETE /sensordata/1
    def destroy
      @sensordatum.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_sensordatum
        @sensordatum = Sensordatum.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def sensordatum_params
        params.require(:sensordatum).permit(:type, :data)
      end
  end
end
