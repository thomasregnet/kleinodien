# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artists/show', type: :view do
  before do
    @artist = assign(:artist, Artist.create!(
                                name:           'My Artist',
                                sort_name:      'Artist, my',
                                disambiguation: 'This and no other',
                                brainz_code:    '28728f82-7c12-11eb-833d-08606e75dc17',
                                discogs_code:   444,
                                imdb_code:      555,
                                tmdb_code:      666,
                                wikidata_code:  777
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/My Artist/)
    expect(rendered).to match(/Artist, my/)
    expect(rendered).to match(/This and no other/)
    expect(rendered).to match(/28728f82-7c12-11eb-833d-08606e75dc17/)
    expect(rendered).to match(/444/)
    expect(rendered).to match(/555/)
    expect(rendered).to match(/666/)
    expect(rendered).to match(/777/)
  end
end
