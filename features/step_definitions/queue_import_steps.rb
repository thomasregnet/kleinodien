When("I visit the import brainz release page") do
  visit new_brainz_release_import_request_path
end

When("I fill in a code") do
  @code = 'a22ce8a1-a331-428a-8971-ffc1b2aecd7a'
  fill_in 'Code', with: @code
  click_button 'import'
end

Then("that code is queued") do
  redis = ImportConnection.redis
  expect(redis.lindex('brainz:requests', 0)).to eq(@code)
end
