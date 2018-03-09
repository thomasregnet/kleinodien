Feature: Store and fetch on import cache

  In order to cache data for imports
  as an import service
  I want to store and fetch data on the import cache

  # make shure that stored data can be fetched

  Scenario: Store and fetch data
    When I store data to the import cache
    And I fetch that data from the import cache
    Then the data is equal
