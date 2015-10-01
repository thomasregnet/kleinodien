require 'omdb_test_helper'

Given(/^The movie\-head with omdb id "(.*?)" exists$/) do |omdb_id|
  @omdb_id    = omdb_id
  @movie_head = OmdbTestHelper.import_movie(@omdb_id)
end

When(/^I visit the movie_heads page$/) do
  visit 'movie_heads'
end
