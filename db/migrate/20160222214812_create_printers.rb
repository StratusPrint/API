class CreatePrinters < ActiveRecord::Migration[5.0]
  def change
    create_table :printers do |t|
      t.text :manufacturer
      t.text :model
      t.text :friendly_id
      t.text :num_jobs
      t.text :description
      t.text :status, :default => 'offline'
      t.timestamps
    end

    add_index :printers, :friendly_id, :unique => true
  end
end
