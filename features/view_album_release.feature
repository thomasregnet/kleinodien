Feature: View album release

  in order to see an album content
  as a user
  I want to see an album

  Scenario: View a simple Album (AC/DC - Highway To Hell)
    Given The album release with discogs id "940468" exists
    When I visit the album_releases page
    And I follow the link to that album
    Then I will see the contents of the album release
    And I will see the credit "Cliff Williams" - "Bass"
    And I will see the credit "Kevin Dallimore" - "Engineer [Assistant]"
    And I will see the reference "Discogs" identifier "940468"

  Scenario: View a complex album: Cannibal Corpse - Dead Human Collection
    Given The album release with discogs id "4462260" exists
    When I visit the album_releases page
    And I follow the link to that album
    Then I will see the Label "Metal Blade Records GmbH" catalog "3984-15180-0"
    Then I will see the identifier "Barcode" "39841518009"
    Then I will see the format "All Media"
    Then I will see the format "3 x CD"
    Then I will see the identifier "Mastering SID Code (CD 1)" "IFPI L553"
    Then I will see the identifier "Mould SID Code (CD 4)" "IFPI 94K7"
    Then I will see the contents of the album release
