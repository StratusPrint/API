class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.text :file
      t.timestamp :started
      t.timestamp :completed
      t.text :status
      t.integer :duration
      t.decimal :progress
      t.text :status_code
      t.timestamps
    end
  end
end
