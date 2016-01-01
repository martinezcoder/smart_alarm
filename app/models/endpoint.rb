# == Schema Information
#
# Table name: endpoints
#
#  id         :uuid             not null, primary key
#  name       :string
#  state      :integer
#  expires    :integer
#  sent_alert :integer
#  retries    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Endpoint < ActiveRecord::Base
  enum state: [ :disable, :enable, :zombie ]
end
