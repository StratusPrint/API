module Api::V1
  class CommandsController < ApiController
    ###########################################################################
    # AUTHORIZATION
    ###########################################################################
    load_and_authorize_resource :printer
    load_and_authorize_resource :command, :through => :printer

    ###########################################################################
    # SWAGGER API DOCUMENTATION
    ###########################################################################
    swagger_path '/printers/{id}/commands' do
      operation :post do
        key :summary, 'Send a command to the printer'
        key :description, 'Sends a command to the printer.'
        key :operationId, 'issuePrinterCommand'
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
          key :name, :name
          key :in, :body
          key :enum, ['start', 'pause', 'cancel']
          key :description, 'The command to send to the printer'
          key :required, :true
          key :type, :string
        end
        response 201 do
          key :description, 'Command successfully issued'
          schema do
            key :'$ref', :Command
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
      operation :get do
        key :summary, 'List all commands sent to a printer'
        key :description, 'Fetch a list of all commands issued to a printer'
        key :operationId, 'listIssuedPrinterCommands'
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
          key :description, 'A list of commands'
          schema do
            key :'$ref', :Command
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
    swagger_path '/commands/{id}' do
      operation :patch do
        key :summary, 'Update the status of an issued command'
        key :description, 'Used by the hub to set whether a command was successfully executed or not.'
        key :operationId, 'updatePrinterCommand'
        key :tags, [
          'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the command'
          key :required, :true
          key :type, :integer
        end
        parameter do
          key :name, :status
          key :in, :body
          key :enum, ['issued', 'executed', 'errored']
          key :description, 'The status of the command'
          key :required, :true
          key :type, :string
        end
        parameter do
          key :name, :executed_at
          key :in, :body
          key :description, 'The time when the command was executed'
          key :required, :true
          key :type, :'date-time'
        end
        response 200 do
          key :description, 'Command successfully updated'
          schema do
            key :'$ref', :Command
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
      operation :get do
        key :summary, 'Find command by ID'
        key :description, 'Fetches a command if user has access'
        key :operationId, 'findCommandById'
        key :tags, [
          'Printer Management'
        ]
        response 200 do
          key :description, 'Command object'
          schema do
            key :'$ref', :Command
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
      operation :delete do
        key :summary, 'Delete command by ID'
        key :description, 'Delete a command if user has access. Required admin priveleges.'
        key :operationId, 'deleteCommandById'
        key :tags, [
          'Printer Management'
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of the command'
          key :required, :true
          key :type, :integer
        end
        response 204 do
          key :description, 'Command successfully deleted'
          schema do
            key :'$ref', :Command
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
    before_action :set_command, only: [:show, :update, :destroy]

    # GET /commands
    def index
      @commands = Command.all

      render json: @commands
    end

    # GET /commands/1
    def show
      render json: @command
    end

    # POST /commands
    def create
      @command = Command.new(command_params.merge(:issued_by_user => current_user.id))
      printer = Printer.find(params[:printer_id])

      if @command.save
        printer.commands << @command
        SendPrinterCommandJob.perform_later(params[:name], printer)
        render json: @command, status: :created, location: @command
      else
        render json: @command.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /commands/1
    def update
      if @command.update(command_params)
        render json: @command
      else
        render json: @command.errors, status: :unprocessable_entity
      end
    end

    # DELETE /commands/1
    def destroy
      @command.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def command_params
      params.fetch(:command, {}).permit(:name, :status, :executed_at)
    end
  end
end
