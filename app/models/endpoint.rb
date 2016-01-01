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

  scope :non_zombie, -> { where.not(state: Endpoint.states[:zombie]) }

  before_save :set_expires_at
  before_create :set_defaults

  private

  def set_expires_at
    self.expires = (Time.now + 10.days).to_i
  end

  def set_defaults
    self.retries = 0
    self.state = 1
  end
end
