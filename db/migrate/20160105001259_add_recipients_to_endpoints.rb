class AddRecipientsToEndpoints < ActiveRecord::Migration
  def change
    add_column :endpoints, :recipients, :text
  end
end
