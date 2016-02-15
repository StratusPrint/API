module Api::V1
  class PrintjobsController < ApiController
    before_action :set_printjob, only: [:show, :update, :destroy]

    # GET /printjobs
    def index
      @printjobs = Printjob.all

      render json: @printjobs
    end

    # GET /printjobs/1
    def show
      render json: @printjob
    end

    # POST /printjobs
    def create
      @printjob = Printjob.new(printjob_params)

      if @printjob.save
        render json: @printjob, status: :created, location: @printjob
      else
        render json: @printjob.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /printjobs/1
    def update
      if @printjob.update(printjob_params)
        render json: @printjob
      else
        render json: @printjob.errors, status: :unprocessable_entity
      end
    end

    # DELETE /printjobs/1
    def destroy
      @printjob.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_printjob
        @printjob = Printjob.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def printjob_params
        params.require(:printjob).permit(:status, :progress)
      end
  end
end