Feature: Repository

  In order to store tracks and compilations of my collection
  As a user
  I want to handle repositories

  Scenario: Create a repository
    Given User exists
    When I visit the Sign in page
    And I Fill in email and password
    And I visit the repositories page
    
