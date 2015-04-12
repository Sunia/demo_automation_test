class ReplyController < ApplicationController
  skip_before_filter :authenticate_user!

  # To ask the reply of the question
  def ask_answer
    @sender_detail = SenderDetail.where(:unique_key => params[:link]).first
    if @sender_detail.nil?
      flash[:notice] = "Invalid Token"
      redirect_to sorry_path
    else
      @sender = EmailSender.find(@sender_detail.user_id).email
      
      @email = Email.find(@sender_detail.email_id)
      @listener = EmailSender.find(@email.listener_id)
      @question = @email.question
    end
  end

  def submit_answer
    # Find the record of the Sender details and update reply and status of reply.
    @sender_detail = SenderDetail.find(params[:sender_detail][:id])
    @sender_detail.update_attributes(:reply => params[:sender_detail][:reply], :reply_time => Time.now, :is_replied => true)
    all_senders_replied = all_replied
   # Check whether all senders have replied to the answer
   if all_senders_replied
    # send email to listener.
     send_mail_to_listener
   end
   redirect_to thanks_path
  end

  private 

   def all_replied
     all_replied = false
     @email_id = @sender_detail.email_id
     @senders = SenderDetail.where(:email_id => @email_id)

     #@senders.each {|sender| sender.is_replied == true ? all_replied = true : all_replied = false}
     @senders.each do |sender|
       if sender.is_replied == false
        return false
       end 
       all_replied = true if sender.is_replied == true
     end
     return all_replied
   end

  def send_mail_to_listener
    # Find the listener of the email
    listener_id = Email.find(@email_id).listener_id
    @listener = EmailSender.where(:id => listener_id).first

    # send email
    email = Email.where(:id => @email_id).first
    EmailMailer.listener_mail(@listener, email).deliver_now
  end

end