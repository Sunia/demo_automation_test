# Create the roles
def clear_cache
  Rails.cache.clear
end

def create_user
  # Create the User
  @user = FactoryGirl.create(:user0)
end

