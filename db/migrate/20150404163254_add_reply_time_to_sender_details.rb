class AddReplyTimeToSenderDetails < ActiveRecord::Migration
  def change
    add_column :sender_details, :reply_time, :datetime
  end
end
