class SendPrinterCommandJob < ApplicationJob
  queue_as :default

  def perform(command, printer)
    @hub = printer.hub
    @command = command

    begin
      RestClient.post(hub_endpoint) { |response, request, result, &block|
        case response.code
        when 201
          logger.info "#{command} command successfully sent to hub ##{@hub.id} for printer ##{printer.id}."
          logger.debug "Response from hub: " + response
        end
      }
    rescue
      logger.info "Unable to send #{command} command to hub ##{@hub.id} for printer ##{printer.id}."
    end
  end

  private
  def hub_endpoint
    "http://#{@hub.ip}/#{@hub.id}/printers/#{@printer.id}/#{@command}"
  end
end
