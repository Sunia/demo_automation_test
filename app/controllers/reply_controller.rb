class ReplyController < ApplicationController
  skip_before_filter :authenticate_user!

  # To ask the reply of the question
  def ask_answer
    @sender_detail = SenderDetail.where(:unique_key => params[:link]).first
    if @sender_detail.nil?
      flash[:notice] = "Invalid Token"
      redirect_to sorry_path
    else
      email = Email.find(@sender_detail.email_id)
      @question = email.question
    end
  end

  # Submit the answer
  def submit_answer
    @sender_detail = SenderDetail.find(params[:sender_detail][:id])
    @sender_detail.update_attributes(:reply => params[:sender_detail][:reply], :reply_time => Time.now)

    redirect_to thanks_path
  end

  def thanks_message
  end

  def sorry_message
  end
end