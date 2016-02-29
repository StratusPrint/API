module Api::V1
  class PrintersController < ApiController
    before_action :set_printer, only: [:show, :update, :destroy]

    load_and_authorize_resource :hub
    load_and_authorize_resource :printer, :through => :hub

    include DeviseTokenAuth::Concerns::SetUserByToken
    include Swagger::Blocks

    swagger_path '/printers/{id}' do
      operation :get do
        key :description, 'Fetches a single printer if user has access'
        key :operationId, 'findPrinterById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printers'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
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

    swagger_path '/printers/{id}/jobs' do
      operation :get do
        key :description, 'Fetches a list of jobs associated with the given printer'
        key :operationId, 'findPrinterJobById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printers', 'Printer Jobs'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'job response'
          schema do
            key :'$ref', :Job
          end
        end
      end
    end

    # GET /printers
    def index
      @printers = Hub.find_by(id: params[:hub_id]).printers

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
