class EmailService
  attr_reader :client, :alarm, :email_data

  def initialize()
    @client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])
  end
end
