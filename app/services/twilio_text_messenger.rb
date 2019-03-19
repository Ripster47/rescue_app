class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call(user)
    client = Twilio::REST::Client.new
    client.messages.create({
      from: Rails.application.credentials.twilio_phone_number,
      to: user.formatted_phone,
      body: message
    })
  end

   def call_admin
    client = Twilio::REST::Client.new
    client.messages.create({
      from: Rails.application.credentials.twilio_phone_number,
      to: +18474144843,
      body: message
    })
  end

end