class JobSerializer < ActiveModel::Serializer
  attributes :id, :file, :started, :completed, :status, :duration, :progress, :status_code
end
