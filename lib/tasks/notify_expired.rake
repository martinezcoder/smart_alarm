namespace :notify_expired do
  task run: :environment do
    expired = Endpoint.where("expires_at < ? and retries < ?", Time.now.to_i, 3)
    puts expired.count
    expired.each do |alarm|
      data = {}
      data[:sender] = ENV['EMAIL_SENDER']
      data[:recipient_list] = alarm.recipients.split(",")
      data[:subject] = "Alarma #{alarm.name}"
      data[:text] = "La alerta #{alarm.name} ha expirado el dia #{Time.at(alarm.expires_at).to_s}"
      EmailService.new(alarm, data).send
    end
  end
end

