class Email < ActiveRecord::Base
#  has_many :senders

    # Instance method
    # Self contains one email
    # This method generates the details of the email.
    def generate_email_details
      email_details = {}
      email_details[:id] = id
      email_details[:questioner] = User.find(questioner_id).username
      email_details[:listener_id] = User.find(listener_id).email
      email_details[:question] =  question
      email_details[:sender_ids] = sender_ids.reject! { |c| c.blank? }
      return email_details
    end
end
