class CreatePrinters < ActiveRecord::Migration[5.0]
  def change
    create_table :printers do |t|
      t.string :make
      t.string :jobs
      t.string :manufacturer
      t.string :model
      t.string :status

      t.timestamps
    end
  end
end
