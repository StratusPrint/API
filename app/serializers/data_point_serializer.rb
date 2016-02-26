class DataPointSerializer < ActiveModel::Serializer
  attributes :id, :value, :created_at
end
