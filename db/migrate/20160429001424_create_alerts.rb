class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.text :category
      t.text :title
      t.text :message
      t.datetime :time
      t.text :snapshot
      t.timestamps
    end
  end
end
