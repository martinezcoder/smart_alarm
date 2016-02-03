# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  user_id    :string
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :contacts_endpoints
  has_many :endpoints, through: :contacts_endpoints
end
