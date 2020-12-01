require 'rails_helper'

RSpec.describe 'release_heads/index', type: :view do
  before do
    assign(:release_heads, [
             ReleaseHead.create!(
               title:          'my title',
               disambiguation: 'my disambiguation',
               brainz_code:    '',
               imdb_code:      2,
               tmdb_code:      3,
               wikidata_code:  4,
             ),
             ReleaseHead.create!(
               title:          'my title',
               disambiguation: 'my disambiguation',
               brainz_code:    '',
               imdb_code:      2,
               tmdb_code:      3,
               wikidata_code:  4,
             )
           ])
  end

  it 'renders a list of release_heads' do
    render
    assert_select 'tr>td', text: 'my title'.to_s, count: 2
    assert_select 'tr>td', text: 'my disambiguation'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 4.to_s, count: 2
  end
end
