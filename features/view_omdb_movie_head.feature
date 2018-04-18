Feature: View a movie-head imported from omdb

  Anyone can see the contents of a movie-head
  imported from omdb.

  Scenario: See the contents of 'Braindead'
    Given The movie-head with omdb id "763" exists
    When I visit the movie_heads page
    And I follow the link to that movie-head
    Then I will see the contents of that movie-head
    
