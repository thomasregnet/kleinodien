When(/^I send a MusicBrainz id of a release i want to import$/) do
  post(
    '/api/v01/brainz_releases',
    {
      data:
        {
          type: 'music_brainz_releases',
          attributes: {
            wanted: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4'
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
  brainz_id = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4'

  expected_url = 'http://musicbrainz.org/ws/2/release/'\
                 "#{brainz_id}"\
                 '?inc=artists+labels+recordings+release-groups'

  data = JSON.parse(last_response.body)
  uri = data['data']['attributes']['required']['brainz'][0]
  expect(uri).to eq expected_url
end
