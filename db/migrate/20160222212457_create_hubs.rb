class CreateHubs < ActiveRecord::Migration[5.0]
  def change
    create_table :hubs do |t|
      t.string :label
      t.string :location
      t.string :ip
      t.string :hostname
      t.string :api_key
      t.timestamps
    end
  end
end
