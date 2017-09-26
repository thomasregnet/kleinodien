Feature: Import a MusicBrainz Release

  In order to provide users album-data
  as an importer
  I want to import MusicBrainz-Releases

  Scenario: Import a MusicBrainz Release
    When I send a MusicBrainz id of a release i want to import
    And I send all requested data
    Then I receive 201
