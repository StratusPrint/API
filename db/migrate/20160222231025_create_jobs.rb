class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :job_id
      t.text :data, default: '{"status": "processing", "file": {"name": "string", "origin": "sdcard", "size": 0, "date": 0 }, "estimated_print_time": 0, "filament": {"length": "string", "volume": "string"}, "progress": {"completion": "string", "file_position": 0, "print_time": 0, "print_time_left": 0 } }'
      t.timestamps
    end
    add_index :jobs, :job_id, :unique =>true
  end
end
