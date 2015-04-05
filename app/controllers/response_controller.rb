class ResponseController < ApplicationController
  skip_before_filter :authenticate_user!

  def listener_response
    @email = Email.where(:listener_link => params[:link]).first

    listener_id = Email.find(@email.id).listener_id
    @listener = EmailSender.where(:id => listener_id).first

    @senders = @email.sender_ids.reject! { |c| c.blank? }
  end

end
