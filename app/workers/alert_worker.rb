class AlertWorker
  include Sidekiq::Worker

  def perform(alarm_id, expired = false)
    alarm = Endpoint.find alarm_id
    alarm.sent_alert = Time.now.to_i
    alarm.event_based_alert? ? perform_event_based(alarm) : perform_downtime(alarm, expired)
    alarm.save
  end

  private

  def perform_event_based alarm
    data = initial_data alarm
    data[:text] = "Se ha recibido el evento correspondiente a la alarma #{alarm.name} el dia #{Time.at(alarm.expires_at).to_s}"

    EmailService.new(alarm, data).send
  end

  def perform_downtime(alarm, expired)
    data = initial_data alarm

    if expired
      data[:text] = "La alerta #{alarm.name} ha expirado el dia #{Time.at(alarm.expires_at).to_s}"
      alarm.retries += 1
      alarm.status = Endpoint.statuses[:zombie]
      EmailService.new(alarm, data).send
    elsif alarm.zombie?
      data[:text] = "La alerta #{alarm.name} ha vuelto a la normalidad el dia #{Time.at(alarm.expires_at).to_s}"
      alarm.retries = 0
      alarm.status = Endpoint.statuses[:enable]
      EmailService.new(alarm, data).send
    end
  end

  def initial_data alarm
    data = {}
    data[:sender] = ENV['EMAIL_SENDER']
    data[:recipient_list] = alarm.recipients.split ","
    data[:subject] = "Alarma #{alarm.name}"
    data
  end
end
