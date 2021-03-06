require 'capybara/rspec'
require 'factory_girl_rails'
require "selenium-webdriver"
require 'database_cleaner'

RSpec.configure do |config|

  config.use_transactional_fixtures = false

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
