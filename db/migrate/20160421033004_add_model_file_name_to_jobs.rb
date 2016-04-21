class AddModelNameToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :model_file_name, :text
  end
end
