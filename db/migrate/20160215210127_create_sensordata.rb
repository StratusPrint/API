class CreateSensordata < ActiveRecord::Migration[5.0]
  def change
    create_table :sensordata do |t|
      t.string :type
      t.string :data

      t.timestamps
    end
  end
end
