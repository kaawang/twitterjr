class CreateUser < ActiveRecord::Migration
  create_table :users do |t|
    t.string :user_name
    t.string :password_hash

    t.timestamps
  end
end
