When(/^I visit the album release page$/) do
  visit album_release_path(@release.id)
end

When(/^I click the link to add it as original to my collection$/) do
  click_link 'add as original'
end
