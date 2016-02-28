class AddPhoneNumberToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone_number, :string
  end
end
