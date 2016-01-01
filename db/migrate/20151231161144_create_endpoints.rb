class CreateEndpoints < ActiveRecord::Migration
  def change
    create_table :endpoints, id: :uuid do |t|
      t.string :name
      t.integer :state
      t.integer :expires, limit: 8
      t.integer :sent_alert, limit: 8
      t.integer :retries

      t.timestamps null: false
    end
    add_index :endpoints, :expires
    add_index :endpoints, :state
  end
end
