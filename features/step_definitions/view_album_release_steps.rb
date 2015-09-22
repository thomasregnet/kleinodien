require 'discogs_test_helper'

Given(/^The album release with discogs id "(.*?)" exists$/) do |discogs_id|
  @discogs_id = discogs_id
  @release    = DiscogsTestHelper.import_release(@discogs_id)
end

When(/^I visit the album_releases page$/) do
  visit 'album_releases'
end

When(/^I follow the link to that album$/) do
  click_link @release.title
end

Then(/^I will see the contents of the album release$/) do
  #pending # express the regexp above with the code you wish you had
  expect(page).to have_content @release.title
end
