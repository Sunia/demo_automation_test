desc "Installing all the required files in the application"
task :cron => :environment do
  puts "send email to listener after 24 hours"
  @emails =  Email.where("created_at < ?", Time.now - 5.minutes).where(:is_email_sent => false)
  unless @emails.nil?
    EmailMailer.mail_listener_24hours(@emails)
  end

end