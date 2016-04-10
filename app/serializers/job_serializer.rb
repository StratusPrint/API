class JobSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :data
end
