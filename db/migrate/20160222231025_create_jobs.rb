class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :job_id
      t.jsonb :data
      t.timestamps
    end
    add_index :jobs, :job_id, :unique =>true
  end
end
