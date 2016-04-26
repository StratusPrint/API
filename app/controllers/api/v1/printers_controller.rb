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
          'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'Printer object'
          schema do
            key :'$ref', :Printer
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
      end
      operation :patch do
        key :summary, 'Update printer by ID'
        key :description, 'Update the specified printer if user has access.'
        key :operationId, 'updatePrinter'
        key :tags, [
          'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
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
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
        response 422 do
          key :description, 'Validation error(s) - see response for details'
        end
      end
      operation :delete do
        key :summary, 'Delete an existing printer'
        key :description, 'Deletes an existing printer. Requires admin priveleges.'
        key :operationId, 'deletePrinter'
        key :tags, [
          'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 204 do
          key :description, 'Printer successfully deleted'
        end
        response 401 do
          key :description, 'Unauthorized access'
        end
        response 404 do
          key :description, 'Printer not found'
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
          'Printer Management', 'Job Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'List of jobs'
          schema do
            key :'$ref', :Job
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
      end
      operation :post do
        key :summary, 'Add job to printer'
        key :description, 'Add a job to specified printer if user has access.'
        key :operationId, 'addPrinterJob'
        key :tags, [
          'Printer Management', 'Job Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        parameter do
          key :name, :job
          key :in, :body
          key :description, 'Job object'
          key :required, true
          schema do
            key :'$ref', :Job
          end
        end
        response 201 do
          key :description, 'Job successfully added to printer'
          schema do
            key :'$ref', :Job
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
        response 422 do
          key :description, 'Validation error(s) - see response for details'
        end
      end
    end
    swagger_path '/printers/{id}/completed_jobs' do
      operation :get do
        key :summary, 'List all completed for a printer'
        key :description, 'Fetches a list of completed jobs associated with the given printer. Note that user must have access to the parent printer to carry out this action.'
        key :operationId, 'findCompletedPrinterJobs'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printer Management', 'Job Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'List completed of jobs'
          schema do
            key :'$ref', :Job
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
      end
    end
    swagger_path '/printers/{id}/queued_jobs' do
      operation :get do
        key :summary, 'List all queued for a printer'
        key :description, 'Fetches a list of queued jobs associated with the given printer. Note that user must have access to the parent printer to carry out this action.'
        key :operationId, 'findQueuedPrinterJobs'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printer Management', 'Job Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'List queued of jobs'
          schema do
            key :'$ref', :Job
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
      end
    end
    swagger_path '/printers/{id}/processing_jobs' do
      operation :get do
        key :summary, 'List all queued for a printer'
        key :description, 'Fetches a list of processing jobs associated with the given printer. Note that user must have access to the parent printer to carry out this action.'
        key :operationId, 'findProcessingPrinterJobs'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printer Management', 'Job Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'List processing of jobs'
          schema do
            key :'$ref', :Job
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
        end
      end
    end
    swagger_path '/printers/{id}/current_job' do
      operation :get do
        key :summary, 'Retrieve the current job for a printer'
        key :description, 'Fetches the job being printed by a given printer. Note that user must have access to the parent printer to carry out this action.'
        key :operationId, 'findCurrentPrinterJob'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Printer Management', 'Job Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the printer'
          key :required, :true
          key :type, :integer
        end
        response 200 do
          key :description, 'The current job'
          schema do
            key :'$ref', :Job
          end
        end
        response 401 do
          key :description, 'Authorization error'
        end
        response 403 do
          key :description, 'No permission to access'
        end
        response 404 do
          key :description, 'Printer not found'
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

    # GET /printers/1/current_job
    def show_current_job
      @jobs = Printer.find_by(id: params[:id]).jobs

      current_job = @jobs.all.select { |j|
        j.data['status'] == 'slicing' or
        j.data['status'] == 'printing' or
        j.data['status'] == 'paused'
      }.last

      render json: current_job
    end

    # GET /printers/1/queued_jobs
    def show_queued_jobs
      @jobs = Printer.find_by(id: params[:id]).jobs

      queued_jobs = @jobs.all.select { |j|
        j.data['status'] == 'queued'
      }

      render json: queued_jobs.sort_by(&:created_at).reverse
    end

    # GET /printers/1/processing_jobs
    def show_processing_jobs
      @jobs = Printer.find_by(id: params[:id]).jobs

      processing_jobs = @jobs.all.select { |j|
        j.data['status'] == 'processing'
      }

      render json: processing_jobs.sort_by(&:created_at).reverse
    end

    # GET /printers/1/completed_jobs
    def show_completed_jobs
      @jobs = Printer.find_by(id: params[:id]).jobs

      completed_jobs = @jobs.all.select { |j|
        j.data['status'] == 'completed'
      }

      render json: completed_jobs.sort_by(&:created_at).reverse
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
      params.fetch(:printer, {}).permit(:friendly_id, :manufacturer, :model, :num_jobs, :description, :status)
    end
  end
end
