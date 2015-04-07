class EmailMailer < ApplicationMailer
  require 'securerandom'

  # Send email to the senders for asking question.
  def self.send_email(email_details)
    @email = email_details
    @email[:sender_ids].each do |sender_id|
      # Generate unique token for each sender and save the sender details in the database.
      # return @sender and @shorten_link
      #ApplicationMailer.create_sender_details(sender_id, @email[:id])
      
      @sender = EmailSender.where(:id => sender_id).first
      random_key = Digest::SHA1.hexdigest @sender.email +  SecureRandom.hex
      #random_key = generate_unique_link(@sender.email)
      
      @shorten_link = Rails.application.secrets.sender_link + random_key
      # Create the sender details
      sender_details = SenderDetail.create(:email_id => @email[:id], :user_id => @sender[:id], :unique_key => random_key)
      
      # Email send to particular senders for replying the email.
      mail_to_sender(@sender,@email, @shorten_link).deliver
      puts "H"
    end
  end

  def listener_mail(listener , email)
    # Generate unique token for each listener and update the email with listener link.
    # return @shorten_link
    @listener = listener
    create_listener_details(@listener, email)
    # Email send to particular listener for showing the response.
    mail(to: @listener.email, subject: 'We have a message for you') 
  end

  def mail_to_sender(sender,email, shorten_link)
     @shorten_link = shorten_link
     @email = email
     @sender = sender
     mail(to: @sender.email, subject: 'Please answer the Question')
   end

   def generate_unique_link(email)
    loop do
      token = Digest::SHA1.hexdigest email +  SecureRandom.hex
      user = Email.find_by_listener_link(token)
      return token unless user
    end
  end
end