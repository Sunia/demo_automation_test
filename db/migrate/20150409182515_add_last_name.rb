class AddLastName < ActiveRecord::Migration
  def change
    add_column :email_senders, :last_name, :string, :default => ""
  end
end
