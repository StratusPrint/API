class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :status
      t.string :progress
      t.string :creator

      t.timestamps
    end
  end
end
