Feature: Queue an import

  In order to get external data imported
  as a user
  I want to queue imports

  Scenario: Queue a MusicBrainz release
    When I visit the import brainz release page
    And I fill in a code
    Then that code is queued
