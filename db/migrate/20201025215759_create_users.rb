class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :encrypted_access_token
      t.string :encrypted_access_token_iv
      t.timestamps
    end
  end
end
