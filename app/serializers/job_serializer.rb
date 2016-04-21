class JobSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :model_file_url, :model_file_name, :model_file_extension, :model_file_name_full, :data
end

def model_file_url
  self.model.url
end

def model_file_name
  self.model_file_name
end

def model_file_extension
  File.extname(self.model.url)
end

def model_file_name_full
  "#{model_file_name}#{model_file_extension}"
end
