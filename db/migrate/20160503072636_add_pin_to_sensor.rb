class AddPinToSensor < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :pin, :integer
  end
end
