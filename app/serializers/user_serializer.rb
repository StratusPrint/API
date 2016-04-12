class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :email, :admin
end
