class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.string :unique_key, null: false, default: ""
      t.text :reply, null: false, default: ""
      t.integer :email_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
