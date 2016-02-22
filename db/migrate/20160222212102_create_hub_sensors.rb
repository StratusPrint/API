class CreateHubSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :hub_sensors do |t|
      t.belongs_to :sensor
      t.belongs_to :hub
      t.timestamps
    end
  end
end
