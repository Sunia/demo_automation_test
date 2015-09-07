Feature: Login
  As a active user
  In order to access the site content
  I need to log in to the site
 
  Scenario: valid credentials
   Given I am on the login page
   When I provide the valid credentials
   Then I should be successfully logged in
 
  Scenario: invalid credentials
    Given I am on login page
    When I provide the invalid credentials
    Then I should not be logged in