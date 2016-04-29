class CreateSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :sensors do |t|
      t.text :category
      t.text :model
      t.text :manufacturer
      t.text :friendly_id
      t.text :desc
      t.text :low_threshold
      t.text :high_threshold
      t.boolean :alert_generated, :default => false
      t.timestamps
    end

    add_index :sensors, :friendly_id, :unique => true
  end
end
