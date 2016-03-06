module Api::V1
  class PrintersController < ApiController
    ###########################################################################
    # AUTHORIZATION AND AUTHENTICATION
    ###########################################################################
    load_and_authorize_resource :hub
    load_and_authorize_resource :printer, :through => :hub

    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/printers/{id}' do
      operation :get do
        key :summary, 'Find printer by ID'
        key :description, 'Fetches a single printer. Note that user must have access to the parent hub to carry out this action.'
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
      operation :patch do
        key :summary, 'Update printer by ID'
        key :description, 'Update the specified printer if user has access.'
        key :operationId, 'updatePrinter'
        key :tags, [
          'Printers'
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
          key :description, 'Printer successfully updated'
          schema do
            key :'$ref', :Printer
          end
        end
        response 421 do
          key :description, 'Validation error(s)'
        end
        response 401 do
          key :description, 'Unauthorized access'
        end
      end
      operation :delete do
        key :summary, 'Delete an existing printer'
        key :description, 'Deletes an existing printer. Requires admin priveleges.'
        key :operationId, 'deletePrinter'
        key :tags, [
          'Printers'
        ]
        response 204 do
          key :description, 'Printer successfully deleted'
        end
        response 401 do
          key :description, 'Unauthorized access'
        end
      end
    end

    swagger_path '/printers/{id}/jobs' do
      operation :get do
        key :summary, 'List all current and previous jobs managed by a printer'
        key :description, 'Fetches a list of jobs associated with the given printer. Note that user must have access to the parent printer to carry out this action.'
        key :operationId, 'findPrinterJobById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printers', 'Jobs'
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
      operation :post do
        key :summary, 'Add job to printer'
        key :description, 'Add a job to specified printer if user has access.'
        key :operationId, 'addPrinterJob'
        key :tags, [
          'Printers', 'Jobs'
        ]
        parameter do
          key :name, :job
          key :in, :body
          key :description, 'Job object'
          key :required, true
          schema do
            key :'$ref', :Job
          end
        end
        response 200 do
          key :description, 'Job successfully added to printer'
          schema do
            key :'$ref', :Job
          end
        end
        response 421 do
          key :description, 'Validation error(s)'
        end
        response 401 do
          key :description, 'Unauthorized access'
        end
      end
    end

    ###########################################################################
    # CONTROLLER ACTIONS
    ###########################################################################
    before_action :set_printer, only: [:show, :update, :destroy]

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
        Hub.find_by(id: params[:hub_id]).printers << @printer
        render json: @printer, status: :created, location: v1_printer_path(@printer)
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
      params.fetch(:printer, {}).permit(:friendly_id, :manufacturer, :model, :status, :num_jobs)
    end
  end
end
