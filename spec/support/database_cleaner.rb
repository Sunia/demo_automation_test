RSpec.configure do |config|

  config.before(:suite) do

    #DatabaseCleaner.clean_with(:deletion)
    #DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    #DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
  end

  config.before(:each, :js => true) do
    #DatabaseCleaner.strategy = :deletion
    #DatabaseCleaner.clean_with(:deletion)
    
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
