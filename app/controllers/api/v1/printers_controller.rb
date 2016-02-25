module Api::V1
  class PrintersController < ApiController
    before_action :set_printer, only: [:show, :update, :destroy]

    # GET /printers
    def index
      @printers = Printer.all

      render json: @printers
    end

    # GET /printers/1
    def show
      render json: @printer
    end

    # POST /printers
    def create
      @printer = Printer.new(printer_params)

      if @printer.save
        render json: @printer, status: :created, location: @printer
      else
        render json: @printer.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /printers/1
    def update
      if @printer.update(printer_params)
        render json: @printer
      else
        render json: @printer.errors, status: :unprocessable_entity
      end
    end

    # DELETE /printers/1
    def destroy
      @printer.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_printer
      @printer = Printer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def printer_params
      params.fetch(:printer, {})
    end
  end
end
