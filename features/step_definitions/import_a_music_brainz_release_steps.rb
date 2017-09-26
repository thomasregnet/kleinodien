When(/^I send a MusicBrainz id of a release i want to import$/) do
  post(
    '/api/v01/music_brainz_releases',
    { data: { type: 'music_brainz_releases' } },
    headers: { 'Content-Type' => 'application/json' }
  )
end
