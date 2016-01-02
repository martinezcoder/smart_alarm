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

  def event_based_alert?
    expires == nil
  end

  def downtime_alert?
    expires.present?
  end

  private

  def set_expires_at
    self.expires = interval ? (Time.now + interval.minutes).to_i : nil
  end

  def set_defaults
    self.retries = 0
    self.state =  Endpoint.states[:disable]
  end
end
