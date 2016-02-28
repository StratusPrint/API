class HubSerializer < ActiveModel::Serializer
  attributes :id, :friendly_id, :label, :location, :ip, :hostname, :api_token
end
