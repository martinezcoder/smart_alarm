class CreateContacts < ActiveRecord::Migration
  def change
    create_table(:contacts) do |t|
      t.string :email
      t.string :name
      t.string :user_id

      t.timestamps
    end

    add_index :contacts, :user_id
  end
end
