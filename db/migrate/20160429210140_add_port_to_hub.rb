class AddPortToHub < ActiveRecord::Migration[5.0]
  def change
    add_column :hubs, :port, :integer
  end
end
