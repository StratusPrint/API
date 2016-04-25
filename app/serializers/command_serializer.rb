class CommandSerializer < ActiveModel::Serializer
  attributes :id, :status, :name, :created_at, :executed_at, :issued_by_user
end
