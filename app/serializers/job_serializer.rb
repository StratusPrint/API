class JobSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :data
end

#def id
#  object.job_id
#end

def data
  object.data.to_json
end
