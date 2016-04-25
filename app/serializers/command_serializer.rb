class CommandSerializer < ActiveModel::Serializer
  attributes :id, :status, :name, :created_at, :executed_at, :issued_by
end

def issued_by
  User.find(self.issued_by_user).name
end
