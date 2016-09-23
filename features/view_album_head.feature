Feature: View album head

  as a user I want to view album heads

  Scenario: View a simple album head and follow to a release
    Given The album release with discogs id "940468" exists
    When I visit the album_heads page
    And I follow the link to that album head
    Then I will see the releases of that album
    And I will follow the link to the release
    Then I will see the contents of the album release
