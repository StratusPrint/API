class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :email, :admin, :last_sign_in_ip, :last_sign_in_at, :created_at
end
