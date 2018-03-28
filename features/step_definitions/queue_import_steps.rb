When("I visit the new import requests page") do
  visit new_import_request_path
end

When("I choose MusicBrainz release") do
  choose('MusicBrainz release')
end

When("I fill in a code") do
  @code = 'a22ce8a1-a331-428a-8971-ffc1b2aecd7a'
  fill_in 'Code', with: @code
  click_button 'import'
end

Then("that code is queued") do
  redis = ImportConnection.redis
  expect(redis.lindex('brainz:requests', 0)).to match(/#{@code}/)
  expect(redis.lindex('brainz:requests', 0)).to match(/brainz_release/)
end
