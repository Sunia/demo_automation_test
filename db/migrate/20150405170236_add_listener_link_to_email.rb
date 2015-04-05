class AddListenerLinkToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :listener_link, :text
    add_column :emails, :is_email_sent, :boolean, :default => false
  end
end