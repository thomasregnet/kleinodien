require 'omdb_test_helper'

Given(/^The movie\-head with omdb id "(.*?)" exists$/) do |omdb_id|
  @omdb_id    = omdb_id
  @movie_head = OmdbTestHelper.import_movie(@omdb_id)
end

When(/^I visit the movie_heads page$/) do
  visit 'movie_heads'
end

When(/^I follow the link to that movie\-head$/) do
  click_link @movie_head.title
end

Then(/^I will see the contents of that movie\-head$/) do
  expect(page).to have_content @movie_head.title
end

