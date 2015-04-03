class EmailMailer < ApplicationMailer
  require 'securerandom'

  # Send email to the senders for asking question.
  def send_email(email_details)
    @email = email_details
    @email[:sender_ids].each do |sender_id|

      # Generate unique token for each sender and save the sender details in the database.
      create_sender_details(sender_id, @email[:id])

      # Email send to particular senders for replying the email.
      mail(to: @sender.email, subject: 'Please answer the Question') #if @listener != user.username
    end
  end
end
