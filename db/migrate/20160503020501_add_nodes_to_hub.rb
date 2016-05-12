class AddNodesToHub < ActiveRecord::Migration[5.0]
  def change
    add_column :hubs, :nodes, :integer, array: true, default: []
  end
end
