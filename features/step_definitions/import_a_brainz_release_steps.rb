require 'ko_test_data'

When(/^I send a MusicBrainz id of a release i want to import$/) do
  post(
    '/api/v01/brainz_releases',
    {
      data:
        {
          type: 'music_brainz_releases',
          attributes: {
            wanted: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
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
  brainz_release_id = BrainzReleaseId.new(
    '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
  )

  data = JSON.parse(last_response.body)
  uri = data['data']['attributes']['required']['brainz'][0]
  expect(uri).to eq brainz_release_id.source_id
end

When(/^I send the MusicBrainz data of the release I want to import$/) do
  brainz_uri = 'https://musicbrainz.org/ws/2/release/'\
               '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'\
               '?inc=artists+labels+recordings+release-groups'

  post(
    '/api/v01/brainz_releases',
    {
      data:
        {
          type: 'music_brainz_releases',
          attributes: {
            wanted: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
            known: {
              brainz: {
                brainz_uri => KoTestData.brainz_release(
                  '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
                )
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
  brainz_id = '1d93c839-22e7-4f76-ad84-d27039efc048'
  expected_url = 'https://musicbrainz.org/ws/2/artist/'\
                 "#{brainz_id}"\
                 '?inc=url-rels'

  data = JSON.parse(last_response.body)
  required = data['data']['attributes']['required']['brainz']
  #byebug
  expect(required.include?(expected_url)).to be true
end
