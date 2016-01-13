class AddUserIdToEndpoints < ActiveRecord::Migration
  def change
    add_column :endpoints, :user_id, :integer

    add_index :endpoints, :user_id
  end
end
