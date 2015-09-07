#================================================================================

# Scenario:  Valid Credentials
Given(/^I am on the login page$/)do
  create_user
  visit new_user_session_path
end

When(/^I provide the valid credentials$/)do

  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  page.execute_script("$('.signinbutton').click()")
end

Then(/^I should be successfully logged in$/)do
  #expect(page).to have_content("Welcome, #{@user.first_name} #{@user.last_name}")
end

#========================================================

# Scenario:  Invalid Credentials
Given(/^I am on login page$/)do
  visit new_user_session_path
end

When(/^I provide the invalid credentials$/)do
 
  fill_in "_email", :with => "xyz@example.com"
  fill_in "_password", :with => "123456"
  page.execute_script("$('.signinbutton').click()")

end

Then(/^I should not be logged in$/)do
  expect(page).to have_content("Invalid email/password")
end

#=============================================================================