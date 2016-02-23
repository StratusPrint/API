class CreateSensorDataPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :sensor_data_points do |t|
      t.belongs_to :sensor
      t.belongs_to :data_point
      t.timestamps
    end
  end
end
