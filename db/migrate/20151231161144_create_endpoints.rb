class CreateEndpoints < ActiveRecord::Migration
  def change
    create_table :endpoints, id: :uuid do |t|
      t.string :name
      t.integer :status
      t.integer :expires_at, limit: 8
      t.integer :sent_alert, limit: 8
      t.integer :retries
      t.integer :interval

      t.timestamps null: false
    end
    add_index :endpoints, :expires_at
    add_index :endpoints, :status
  end
end
