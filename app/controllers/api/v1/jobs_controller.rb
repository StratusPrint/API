module Api::V1
  class JobsController < ApiController
    before_action :set_job, only: [:show, :update, :destroy]

    load_and_authorize_resource :printer
    load_and_authorize_resource :job, :through => :printer

    include Swagger::Blocks

    swagger_path '/jobs/{id}' do
      operation :get do
        key :summary, 'Find a print job by ID'
        key :description, 'Fetches a single job belonging to a printer'
        key :operationId, 'findJobById'
        key :produces, [
          'application/json'
        ]
        key :tags, [
          'Jobs'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the job'
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

    # GET /jobs
    def index
      @jobs = Printer.find_by(id: params[:printer_id]).jobs

      render json: @jobs
    end

    # GET /jobs/1
    def show
      render json: @job
    end

    # POST /jobs
    def create
      @job = Job.new(job_params)

      if @job.save
        render json: @job, status: :created, location: @job
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /jobs/1
    def update
      if @job.update(job_params)
        render json: @job
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    end

    # DELETE /jobs/1
    def destroy
      @job.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:file, :started, :completed, :status, :duration, :progress, :status_code)
    end
  end
end
