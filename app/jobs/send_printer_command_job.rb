class SendPrinterCommandJob < ApplicationJob
  queue_as :default

  def perform(command, printer)
    @hub = printer.hub
    @command = command
    @printer = printer

    begin
      RestClient.post(hub_endpoint, :command_id => @command.id) { |response, request, result, &block|
        case response.code
        when 201
          logger.info "#{@command.name} command successfully sent to hub ##{@hub.id} for printer ##{@printer.id}."
          logger.debug "Response from hub: " + response
        else
          set_command_errored
        end
      }
    rescue
      set_command_errored
    end
  end

  private
  def hub_endpoint
    "http://#{@hub.ip}:#{@hub.port}/printers/#{@printer.id}/#{@command.name}"
  end

  def set_command_errored
    logger.info "Unable to send #{@command.name} command to hub ##{@hub.id} for printer ##{@printer.id}."
    @command.status = 'errored'
    @command.save
  end
end
