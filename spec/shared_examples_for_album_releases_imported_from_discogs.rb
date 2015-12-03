RSpec.shared_examples 'an AlbumRelease imported from discogs' do
  it 'has the right values set' do
    expect(album_release.title).to eq(title)
    expect(album_release.head.artist_credit.name).to eq(artist_credit_name)
    expect(album_release.countries[0].name).to eq(country)
  end
end
