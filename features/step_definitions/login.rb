#================================================================================

# Scenario:  Valid Credentials
Given(/^I am on the login page$/)do
  create_user
  visit new_user_session_path
end

When(/^I provide the valid credentials$/)do
  sleep(15)
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  sleep(15)
  page.execute_script("$('.signinbutton').click()")
end

Then(/^I should be successfully logged in$/)do
  sleep(10)
  expect(page).to have_content("Signed in successfully.")
end

#========================================================

# Scenario:  Invalid Credentials
Given(/^I am on login page$/)do
  visit new_user_session_path
end

When(/^I provide the invalid credentials$/)do
  
  fill_in "user_email", :with => "xyz@example.com"
  fill_in "user_password", :with => "123456"
  sleep(25)
  page.execute_script("$('.signinbutton').click()")

end

Then(/^I should not be logged in$/)do
  sleep(10)
  expect(page).to have_content("Invalid email or password.")
end

#=============================================================================