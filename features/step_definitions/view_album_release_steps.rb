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
  expect(page).to have_content @release.title
  @release.tracks.each do |t|
    expect(page).to have_content(t.release.title)
  end
end

Then(/^I will see the identifier "(.*?)" "(.*?)"$/) do |type, barcode|
  expect(page).to have_content(type)
  expect(page).to have_content(barcode)
end

Then(/^I will see the Label "(.*?)" catalog "(.*?)"$/) do |label, catalog_no|
  expect(page).to have_content(label)
  expect(page).to have_content(catalog_no)
end

Then(/^I will see the format "(.*?)"$/) do |format|
  expect(page).to have_content(format)
end

Then(/^I will see the credit "(.*?)" \- "(.*?)"$/) do |artist_credit, job|
  expect(page).to have_content("#{artist_credit} - #{job}")
end

Then(/^I will see the source "(.*?)" identifier "(.*?)"$/) do |supplier, id|
  expect(page).to have_content(supplier)
  expect(page).to have_content(id)
end
