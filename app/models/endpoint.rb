# == Schema Information
#
# Table name: endpoints
#
#  id         :uuid             not null, primary key
#  name       :string
#  status     :integer
#  expires_at :integer
#  sent_alert :integer
#  retries    :integer
#  interval   :integer
#  user_id    :integer
#  recipients :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Endpoint < ActiveRecord::Base
  enum status: [ :disable, :enable, :zombie ]
  enum intervals: { "5-minutes": 5.minutes,
                    "15-minutes": 15.minutes,
                    "30-minutes": 30.minutes,
                    "hourly":  1.hour,
                    "daily":   1.day,
                    "weekly":  1.week,
                    "monthly": 1.month }

  scope :non_zombie, -> { where.not(status: Endpoint.statuses[:zombie]) }

  belongs_to :user
  has_many :contacts_endpoints
  has_many :contacts, through: :contacts_endpoints

  accepts_nested_attributes_for :contacts_endpoints

  before_save :set_expires_at
  before_create :set_defaults

  validates :name, presence: true
  validates :interval, inclusion: { in: self.intervals.values, message: "%{value} is not a permitted interval"}, allow_nil: true


  def event_based_alert?
    interval == nil
  end

  def downtime_alert?
    interval.present?
  end

  private

  def set_expires_at
    self.expires_at = downtime_alert? ? (Time.now + interval).to_i : nil
  end

  def set_defaults
    self.retries = 0
    self.status = Endpoint.statuses[:disable]
  end
end

