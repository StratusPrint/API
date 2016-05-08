class GetHubNodesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Hub.all.each do |hub|
      update_node_list(hub)
    end
  end

  private
  def update_node_list(hub)
    begin
      response = RestClient.get("http://#{hub.ip}:#{hub.port}/nodes")
      case response.code
      when 200
        node_list = Array.new
        data = JSON.parse(response)
        data.each do |node|
          node_list.push(node.id)
        end
        hub.nodes = node_list
        hub.save!
        logger.application.info "Successfully retrieved list of node IDs from hub ##{hub.id}: #{node_list}"
      end
    rescue
      # Do nothing
    end
  end
end
