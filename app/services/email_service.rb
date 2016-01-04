class EmailService
  attr_reader :client, :alarm, :email_data

  def initialize(alarm, email_data)
    @client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])
    @email_data = email_data
    @alarm = alarm
  end

  def send
    mail = SendGrid::Mail.new do |m|
      m.to = email_data[:recipient_list]
      m.from = email_data[:sender]
      m.subject = email_data[:subject]
      m.text = email_data[:text]
    end

    res = client.send(mail)
    if res.code == 200
      alarm.sent_alert = Time.now.to_i
      alarm.retries += 1
      alarm.save
    end
  end
end
