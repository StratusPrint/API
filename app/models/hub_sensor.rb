class HubSensor < ApplicationRecord
  belongs_to :hub
  belongs_to :sensor, :dependent => :destroy
end
