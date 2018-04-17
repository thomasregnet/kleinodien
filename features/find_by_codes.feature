Feature: Find an entity by it's codes

  In order to find existing entities
  As part of the library
  I want to find entities by it's code
  
  Scenario Outline: Find an Artist by it's codes
    Given The Artist with <column_name> <code>
    When I call Model#find_by_codes
    Then I get this model 

    Examples:
      | column_name     | code                                   |
      | "brainz_code"   | "8e853607-aa21-442d-a2b1-fead127b9493" |
      | "discogs_code"  | "5432"                                 |
      | "wikidata_code" | "5432"                                 |

