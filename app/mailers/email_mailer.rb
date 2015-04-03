class EmailMailer < ApplicationMailer
  require 'securerandom'
  
  def send_email(email)
    @questioner = User.find(email.questioner_id).username
    @listener = User.find(email.listener_id).email
    @question =  email.question
    @sender_ids = email.sender_ids.reject! { |c| c.blank? }

    @sender_ids.each do |sender_id|
      create_sender_details(sender_id,email)
      mail(to: @sender.email, subject: 'Please answer the Question') #if @listener != user.username
    end
  end

end
