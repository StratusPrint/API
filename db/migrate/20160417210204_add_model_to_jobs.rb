class AddModelToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :model, :text
  end
end
