Feature: Import a MusicBrainz Release

  In order to provide users album-data
  as an importer
  I want to import MusicBrainz-Releases

  Scenario: Send the initial import request
    When I send a MusicBrainz id of a release i want to import
    Then I receive a status of "202"
    And  the response contains an url to get the release-data
 
  Scenario: Send the MusicBrainz release data
    When I send the MusicBrainz data of the release I want to import
    Then I receive a status of "202"
    And I see the artist in the requirements
    
  Scenario: Try to import an existing release
    Given The release already exists
    When I send a MusicBrainz id of a release i want to import
    Then I receive a status of "403"
