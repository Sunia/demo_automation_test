class AddIsRepliedToSenderDetails < ActiveRecord::Migration
  def change
    add_column :sender_details, :is_replied, :boolean, :default => false
  end
end
