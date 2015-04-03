class EmailMailer < ApplicationMailer
  require 'securerandom'
  
    def send_email(email)
      @questioner = User.find(email[:questioner_id]).username
      @listener = User.find(email[:listener_id]).email
      @question =  email[:question]
      @senders = email[:sender_ids].reject! { |c| c.empty? }

      @senders.each do |sender|
        user = User.find(sender)
        @random_key = SecureRandom.hex

        @shorten_link = Rails.application.secrets.sender_link + @random_key
        Sender.create(:email_id => email.id, :user_id => user.id, :unique_key => @random_key)
        mail(to: user.email, subject: 'Please answer the Question') #if @listener != user.username
      end
    end

end
