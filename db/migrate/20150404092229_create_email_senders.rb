class CreateEmailSenders < ActiveRecord::Migration
  def change
    create_table :email_senders do |t|

      t.string :email, null: false, default: ""
      t.string :first_name, null: false, default: ""
      t.timestamps null: false
    end
  end
end
