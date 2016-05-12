class CreatePrinterCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :printer_commands do |t|
      t.belongs_to :printer
      t.belongs_to :command
      t.timestamps
    end
  end
end
