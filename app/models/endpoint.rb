# == Schema Information
#
# Table name: endpoints
#
#  id         :uuid             not null, primary key
#  name       :string
#  status      :integer
#  expires_at :integer
#  sent_alert :integer
#  retries    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Endpoint < ActiveRecord::Base
  enum status: [ :disable, :enable, :zombie ]

  scope :non_zombie, -> { where.not(status: Endpoint.statuses[:zombie]) }

  before_save :set_expires_at
  before_create :set_defaults

  def event_based_alert?
    interval == nil
  end

  def downtime_alert?
    interval.present?
  end

  private

  def set_expires_at
    self.expires_at = downtime_alert? ? (Time.now + interval.minutes).to_i : nil
  end

  def set_defaults
    self.retries = 0
    self.status = Endpoint.statuses[:disable]
  end
end

