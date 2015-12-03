RSpec.shared_examples 'an AlbumRelease imported from discogs' do
  it 'has imported the album' do
    expect(album_release).to be_valid
    expect(album_release).not_to be_new_record
  end

  it 'has title and artist set' do
    expect(album_release.title).to eq(title)
    expect(album_release.head.artist_credit.name).to eq(artist_credit_name)
  end

  it 'has the right date' do
    release_date = album_release.date
    expect(release_date.to_s).to eq(date)
    expect(release_date.mask).to eq(date_mask)
  end

  it 'has the country set' do
    countries = album_release.countries
    expect(countries[0].name).to eq(country)
    expect(countries.length).to eq(1)
  end
end
