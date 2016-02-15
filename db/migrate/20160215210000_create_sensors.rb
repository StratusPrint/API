class CreateSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :sensors do |t|
      t.string :type
      t.string :data
      t.string :desc
      t.string :label

      t.timestamps
    end
  end
end
