class CreateHubs < ActiveRecord::Migration[5.0]
  def change
    create_table :hubs do |t|
      t.text :label
      t.text :friendly_id
      t.text :location
      t.text :ip
      t.text :hostname
      t.text :api_key
      t.timestamps
    end

    add_index :hubs, :friendly_id, :unique => true
  end
end
