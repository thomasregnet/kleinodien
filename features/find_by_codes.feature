Feature: Find an entity by it's codes

  In order to find existing entities
  As part of the library
  I want to find entities by it's code
  
  Scenario Outline: Find an Artist by it's codes
    Given The Artist with <code_key> exists
    When I call Model#find_by_codes
    Then I get this model 

    Examples:
      | code_key        |
      | "brainz_code"   |
      | "discogs_code"  |
      | "wikidata_code" |

  Scenario Outline: Find a CompilationHead by it's codes
    Given The CompilationHead with <code_key> exists
    When I call Model#find_by_codes
    Then I get this model 

    Examples:
      | code_key        |
      | "brainz_code"   |
      | "discogs_code"  |
      | "wikidata_code" |

  Scenario Outline: Find a CompilationRelease by it's codes
    Given The CompilationRelease with <code_key> exists
    When I call Model#find_by_codes
    Then I get this model 

    Examples:
      | code_key        |
      | "brainz_code"   |
      | "discogs_code"  |
      | "imdb_code"     |
      | "tmdb_code"     |
      | "wikidata_code" |

  Scenario Outline: Find a PieceHead by it's codes
    Given The PieceHead with <code_key> exists
    When I call Model#find_by_codes
    Then I get this model 

    Examples:
      | code_key        |
      | "brainz_code"   |
      | "discogs_code"  |
      | "imdb_code"     |
      | "tmdb_code"     |
      | "wikidata_code" |

