class Email < ActiveRecord::Base
#  has_many :senders

    # Instance method
    # Self contains one email
    # This method generates the details of the email.
    def generate_email_details
      email_details = {}
      email_details[:id] = id

      # find the questioner from the User model.
      email_details[:questioner] = User.find(questioner_id).username

      # Find the listener from the EmailSender.
      listener = EmailSender.find(listener_id)
      email_details[:listener_firstname] = listener.first_name
      email_details[:listener_lastname] = listener.last_name
      email_details[:question] =  question
      email_details[:sender_ids] = sender_ids.reject! { |c| c.blank? }
      return email_details
    end
end
