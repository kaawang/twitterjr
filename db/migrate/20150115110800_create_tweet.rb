class CreateTweet < ActiveRecord::Migration
  create_table :tweets do |t|
    t.string :content
    t.integer :user_id

    t.timestamps
  end
end
