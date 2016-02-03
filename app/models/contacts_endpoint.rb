class ContactsEndpoint < ActiveRecord::Base
  belongs_to :contact
  belongs_to :endpoint

  validates :contact, presence: true

  enum kind: [:email, :push, :sms]
end
