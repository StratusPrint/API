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
          logger.info "#{@command} command successfully sent to hub ##{@hub.id} for printer ##{@printer.id}."
          logger.debug "Response from hub: " + response
        end
      }
    rescue
      set_command_errored
    end
  end

  private
  def hub_endpoint
    "http://#{@hub.ip}/#{@hub.id}/printers/#{@printer.id}/#{@command}"
  end

  def set_command_errored
    logger.info "Unable to send #{@command} command to hub ##{@hub.id} for printer ##{@printer.id}."
    @command.status = 'errored'
    @command.save
  end
end
