class AddNodeIdToSensor < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :node_id, :integer
  end
end
