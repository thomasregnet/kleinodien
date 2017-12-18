# frozen_string_literal: true

require 'ko_test_data'

When(/^I send a MusicBrainz id of a release i want to import$/) do
  post(
    '/api/v01/brainz_releases',
    {
      data:
        {
          type: 'music_brainz_releases',
          attributes: {
            offered: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
          }
        }
    },
    headers: {
      'Accept'       => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  )
end

Then(/^I receive a status of "([^"]*)"$/) do |status|
  expect(last_response.status).to eq(status.to_i)
end

Then(/^the response contains an url to get the release\-data$/) do
  reference = BrainzReleaseReference.from_code(
    '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
  )

  data = JSON.parse(last_response.body)
  cache_key = data.dig('data', 'attributes', 'required', 'brainz')[0]
  expect(cache_key).to eq reference.to_key
end

When(/^I send the MusicBrainz data of the release I want to import$/) do
  brainz_id = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
  reference = BrainzReleaseReference.from_code(brainz_id)
  cache_key = reference.to_key

  post(
    '/api/v01/brainz_releases',
    {
      data:
        {
          type: 'music_brainz_releases',
          attributes: {
            offered: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
            known: {
              brainz: {
                cache_key => KoTestData.brainz_release(reference)
              }
            }
          }
        }
    },
    headers: {
      'Accept'       => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  )
end

Then(/^I see the artist in the requirements$/) do
  reference = BrainzArtistReference.from_code(
    '1d93c839-22e7-4f76-ad84-d27039efc048'
  )
  data = JSON.parse(last_response.body)
  required = data.dig('data', 'attributes', 'required', 'brainz')
  expect(required.include?(reference.to_key)).to be true
end

Given(/^The release already exists$/) do
  FactoryGirl.create(
    :compilation_release,
    brainz_code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
  )
end
