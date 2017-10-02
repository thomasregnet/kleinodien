When(/^I send a MusicBrainz id of a release i want to import$/) do
  post(
    '/api/v01/brainz_releases',
    {
      data:
        {
          type: 'music_brainz_releases',
          attributes: {
            wanted: 'abc'
          }
        }
    },
    headers: {
      'Accept'       => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  )
end
