class AlertSerializer < ActiveModel::Serializer
  attributes :id, :category, :title, :message, :time, :snapshot
end
