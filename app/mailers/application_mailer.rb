class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  private

  # # Generate unique token
  # def self.generate_unique_link(email)
    # loop do
      # token = Digest::SHA1.hexdigest email +  SecureRandom.hex
      # user = Email.find_by_listener_link(token)
      # return token unless user
    # end
  # end

  # # Create the sender details when email sends to the sender.
  # def self.create_sender_details(sender_id, email_id)
    # @sender = EmailSender.where(:id => sender_id).first
# 
    # random_key = ApplicationMailer.generate_unique_link(@sender.email)
# 
    # @shorten_link = Rails.application.secrets.sender_link + random_key
# 
    # # Create the sender details
    # sender_details = SenderDetail.create(:email_id => email_id, :user_id => @sender.id, :unique_key => random_key)
    # return @shorten_link, @sender
  # end

  # Create the sender details when email sends to the sender.
  def create_listener_details(listener, email)
    random_key = generate_unique_link(listener.email)

    @shorten_link = Rails.application.secrets.listener_link + random_key

    # Update the listener link in Email Model.
    email.update_attributes(:listener_link => random_key, :is_email_sent => true)
    return @shorten_link
  end


end
