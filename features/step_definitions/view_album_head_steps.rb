When(/^I visit the album_heads page$/) do
  visit 'album_heads'
end

When(/^I follow the link to that album head$/) do
  click_link @release.title
end

Then(/^I will see the releases of that album$/) do
  expect(page).to have_content(@release.head.artist_credit.name)
  expect(page).to have_content(@release.title)
end

Then(/^I will follow the link to the release$/) do
  click_link("#{@release.countries[0].name} #{@release.date}")
end
