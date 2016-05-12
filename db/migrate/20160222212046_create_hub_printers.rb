class CreateHubPrinters < ActiveRecord::Migration[5.0]
  def change
    create_table :hub_printers do |t|
      t.belongs_to :printer
      t.belongs_to :hub
      t.timestamps
    end
  end
end
