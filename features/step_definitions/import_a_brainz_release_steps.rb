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
  last_response.status.should eq(status.to_i)
end

Then(/^the response contains an url to get the release\-data$/) do
  data = JSON.parse(last_response.body)
  mbid = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4'
  #byebug
  data['data']['attributes']['required']['brainz']['compilation_release'][mbid]
    .should eq 'http://musicbrainz.org/ws/2/release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4?inc=artists+labels+recordings+release-groups'
end
