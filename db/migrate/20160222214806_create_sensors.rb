class CreateSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :sensors do |t|
      t.text :label
      t.text :category
      t.text :model
      t.text :manufacturer
      t.text :friendly_id
      t.text :desc
      t.timestamps
    end

    add_index :sensors, :friendly_id, :unique => true
  end
end
