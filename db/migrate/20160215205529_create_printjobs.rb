class CreatePrintjobs < ActiveRecord::Migration[5.0]
  def change
    create_table :printjobs do |t|
      t.string :status
      t.string :progress

      t.timestamps
    end
  end
end
