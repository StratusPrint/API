class HubSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :desc, :location, :ip, :port, :hostname, :status, :nodes
end
