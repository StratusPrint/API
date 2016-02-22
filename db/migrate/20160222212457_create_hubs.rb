class CreateHubs < ActiveRecord::Migration[5.0]
  def change
    create_table :hubs do |t|
      t.string :label
      t.timestamps
    end
  end
end
