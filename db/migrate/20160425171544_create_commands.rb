class CreateCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :commands do |t|
      t.timestamps
      t.text :status, :default => 'issued'
      t.text :name
      t.datetime :executed_at
      t.integer :issued_by_user
    end
  end
end
