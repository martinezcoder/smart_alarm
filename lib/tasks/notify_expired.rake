namespace :notify_expired do
  task run: :environment do
    expired = Endpoint.where("expires < ? and retries < ?", Time.now.to_i, 3)
    puts expired.count
    expired.each do |alarm|
      data = {}
      data[:sender] = ENV['EMAIL_SENDER']
      # TODO
      data[:recipient_list] = []
      data[:subject] = "Alarma #{alarm.name}"
      data[:text] = "La alerta #{alarm.name} ha expirado el dia #{Time.at(alarm.expires).to_s}"
      EmailService.new(alarm, data).send
    end
  end
end

