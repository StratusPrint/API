class AddNumJobsToPrinter < ActiveRecord::Migration[5.0]
  def change
    add_column :printers, :num_jobs, :integer
  end
end
