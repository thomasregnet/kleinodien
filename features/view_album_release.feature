Feature: View album release

  in order to see an album content
  as a user
  I want to see an album

  Scenario: View a simple Album (AC/DC - Highway To Hell)
    Given The album release with discogs id "940468" exists
    When I visit the album_releases page
    And I follow the link to that album
    Then I will see the contents of the album release
