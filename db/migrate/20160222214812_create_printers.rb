class CreatePrinters < ActiveRecord::Migration[5.0]
  def change
    create_table :printers do |t|
      t.text :manufacturer
      t.text :model
      t.text :status
      t.text :friendly_id
      t.text :num_jobs
      t.text :desc
      t.timestamps
    end

    add_index :printers, :friendly_id, :unique => true
  end
end
