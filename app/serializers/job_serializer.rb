class JobSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :model_file_url, :model_file_name, :model_file_extension, :model_file_name_full, :created_by, :data
end

def created_by
  user = User.find(self.created_by_user_id)
  if user
    return user.name
  else
    return ""
  end
end

def model_file_url
  self.model.url
end

def model_file_name
  self.model_file_name
end

def model_file_extension
  if self.model.url.nil?
    return ""
  end
  File.extname(self.model.url)
end

def model_file_name_full
  "#{model_file_name}#{model_file_extension}"
end
