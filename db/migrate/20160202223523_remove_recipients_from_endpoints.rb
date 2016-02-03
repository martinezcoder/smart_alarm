class RemoveRecipientsFromEndpoints < ActiveRecord::Migration
  def change
    remove_column :endpoints, :recipients, :string
  end
end
