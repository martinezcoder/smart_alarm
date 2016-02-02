class CreateContactsEndpoints < ActiveRecord::Migration
  def change
    create_table :contacts_endpoints do |t|
      t.integer :contact_id
      t.uuid :endpoint_id
      t.integer :kind

      t.timestamps
    end
    add_index :contacts_endpoints, [:contact_id, :endpoint_id]
    add_index :contacts_endpoints, :kind
  end
end
