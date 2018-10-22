Feature: Order an import

  In order to get data that i can use in my collection
  as a user
  I want to order imports

  Scenario: Order an import
    When I visit the import_orders page
    And I fill in an suitable url
    And I click the import button
    Then the import is ordered
