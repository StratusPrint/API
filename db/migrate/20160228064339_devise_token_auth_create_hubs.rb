class DeviseTokenAuthCreateHubs < ActiveRecord::Migration
  def change
    create_table(:hubs) do |t|
      ## Hub Info
      t.text :label
      t.text :friendly_id
      t.text :location
      t.text :ip
      t.text :hostname

      ## Required
      t.string :provider, :null => false, :default => "api_token"
      t.string :uid, :null => false, :default => ""

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## TokenAuthenticatable
      t.string   :api_token

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :hubs, [:uid, :provider],     :unique => true
    add_index :hubs, :friendly_id, :unique => true
  end
end
