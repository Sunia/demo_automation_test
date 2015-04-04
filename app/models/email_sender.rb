class EmailSender < ActiveRecord::Base

  validates :email, :uniqueness => true, :presence =>  true

end
