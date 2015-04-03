class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  private

  # Generate unique token
  def generate_unique_link(email)
    loop do
      token = Digest::SHA1.hexdigest email +  SecureRandom.hex
      user = Sender.find_by_unique_key(token)
      return token unless user
    end
  end

# Create the sender details when email sends to the sender.
  def create_sender_details(sender_id, email)
    @sender = User.find(sender_id)
    random_key = generate_unique_link(@sender.email)

    @shorten_link = Rails.application.secrets.sender_link + random_key

    # Create the sender details
    sender_details = Sender.create(:email_id => email.id, :user_id => @sender.id, :unique_key => random_key)
    return @shorten_link, @sender
  end

end
