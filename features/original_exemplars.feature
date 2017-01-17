Feature: Original Exemplar

  As an user
  I want to manage original exemplars in my collection

  Scenario: Add an original exemplar
    Given User exists
    Given The album release with discogs id "940468" exists
    When I visit the album release page
    And I click the link to add it as original to my collection
    And I fill in a disambiguation
    And I press the create button
    Then I will see my new original exemplar

