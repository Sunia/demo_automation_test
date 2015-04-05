class EmailMailer < ApplicationMailer
  require 'securerandom'

  # Send email to the senders for asking question.
  def send_email(email_details)
    @email = email_details
    @email[:sender_ids].each do |sender_id|

      # Generate unique token for each sender and save the sender details in the database.
      # return @sender and @shorten_link
      create_sender_details(sender_id, @email[:id])

      # Email send to particular senders for replying the email.
      mail(to: @sender.email, subject: 'Please answer the Question')
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

end

