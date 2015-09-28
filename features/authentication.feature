Feature: Authentication

  In order to use the application
  As a user
  I want to sing up and sign in

  Scenario: Sign up
    Given I have not signed up
    When I visit the sign-up-path
    And I fill in appropriate values for email and password
    And I press the Sign up Button
    Then I should see "signed up successfully"
    And I should see the logout link
    
