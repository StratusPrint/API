class CheckHubStatusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Hub.all.each do |hub|
      update_hub_status(hub)
    end
  end

  private
  def update_hub_status(hub)
    if hub_alive?(hub)
      logger.info "Hub ##{hub.id} is back online." if hub.status == 'offline'
      logger.info "Hub ##{hub.id} is now online." if hub.status == 'unknown'
      hub.status = "online"
    else
      logger.info "Unable to contact hub ##{hub.id}. Setting status to offline." if hub.status != 'offline'
      hub.status = "offline"
    end
    hub.save
  end

  def hub_alive?(hub)
    begin
      response = RestClient.get("http://#{hub.ip}:#{hub.port}")
      case response.code
      when 200
        return true
      else
        return false
      end
    rescue
      return false
    end
  end
end
