When(/^I visit the album release page$/) do
  visit album_release_path(@release.id)
end

When(/^I click the link to add it as original to my collection$/) do
  click_link 'add as original'
end

When(/^I fill in a disambiguation$/) do
  fill_in 'Disambiguation', with: 'my nice exemplar'
end

Then(/^I will see my new original exemplar$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
