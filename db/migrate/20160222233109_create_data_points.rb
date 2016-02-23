class CreateDataPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :data_points do |t|
      t.text :value
      t.timestamps
    end
  end
end
