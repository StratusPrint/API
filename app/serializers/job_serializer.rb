class JobSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :model_file_url, :data
end

def model_file_url
  self.model.url
end
