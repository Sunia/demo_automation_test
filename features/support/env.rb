require 'cucumber/rails'
require 'byebug'
require 'capybara/rails'
require 'factory_girl_rails'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'selenium-webdriver'
require 'headless'

#Headless
# headless = Headless.new
# headless.start

# at_exit do
#  headless.destroy
# end

ActionController::Base.allow_rescue = false

Cucumber::Rails::Database.javascript_strategy = :truncation

# To set the chrome path.
#Selenium::WebDriver::Chrome::Service.executable_path = '/usr/local/bin/chromedriver'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.javascript_driver = :selenium
Capybara.default_driver = :selenium
 