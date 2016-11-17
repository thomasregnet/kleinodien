Feature: Add a CompilationCopy

  In order to manage my collection
  As a user
  I want to add compilation_copies

  Scenario: Add an album to a repository
    Given The album release with discogs id "940468" exists
    Given User exists
    When I visit the Sign in page
    And I Fill in email and password
    And I visit the repositories page
    And I click the link to create a new repository
    And I fill in a repository name
    And I choose "CDr" as format
    And I press the create button
    When I visit the album_heads page
    And I follow the link to that album head
    Then I will see the releases of that album
    And I will follow the link to the release
    Then I will see the contents of the album release
    And I follow the link 'add to collection'
    And I fill in a explanation
    And I press the create button
    Then I will see the CompilationCopy

