Feature: Add album

  In order to manage my collection
  As a user
  I want to add albums

  # TODO: User must have signed in
  Scenario: Add album to repository
    Given The album release with discogs id "940468" exists
    When I visit the album_heads page
    And I follow the link to that album head
    Then I will see the releases of that album
    And I will follow the link to the release
    Then I will see the contents of the album release
    And I follow the link 'add to collection'
