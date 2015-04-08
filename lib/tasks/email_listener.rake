desc "Installing all the required files in the application"
require 'fileutils'
namespace :after24hours do

  # Checks that the directory you've passed in exists (pulling the directory from the path using File.dirname),
  # and creates it if it does not, it then creates the file.
  task :email => :environment do
    # execute mail after 24 hours.
    @emails = Email.where("created_at < ?", Time.now - 24.hours)
    unless @emails.nil?
      EmailMailer.mail_listener_24hours(@emails)
    end
  end
end