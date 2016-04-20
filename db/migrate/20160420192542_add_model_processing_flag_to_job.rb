class AddModelProcessingFlagToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :model_processing, :boolean, null: false, default: false
  end
end
