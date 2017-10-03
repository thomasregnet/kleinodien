Feature: Import a MusicBrainz Release

  In order to provide users album-data
  as an importer
  I want to import MusicBrainz-Releases

  # TODO: Maybe delete the folowing scenario
  # Scenario: Import a MusicBrainz Release
  #   When I send a MusicBrainz id of a release i want to import
  #   And I send all requested data
  #   Then I receive 201

  Scenario: Send the initial import request
    When I send a MusicBrainz id of a release i want to import
    Then I receive a status of "202"
    And  the response contains an url to get the release-data
 
