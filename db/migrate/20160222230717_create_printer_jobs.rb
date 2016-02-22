class CreatePrinterJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :printer_jobs do |t|
      t.belongs_to :printer
      t.belongs_to :job
      t.timestamps
    end
  end
end
