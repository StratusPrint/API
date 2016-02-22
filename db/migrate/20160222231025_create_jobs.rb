class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :file
      t.timestamp :started
      t.timestamp :completed
      t.string :status
      t.integer :duration
      t.decimal :progress
      t.string :status_code

      t.timestamps
    end
  end
end
