# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artists/new', type: :view do
  before do
    assign(:artist, Artist.new(
                      name:            'MyText',
                      sort_name:       'MyText',
                      disambiguation:  'MyText',
                      brainz_code:     '',
                      discogs_code:    1,
                      imdb_code:       1,
                      tmdb_code:       1,
                      wikidata_code:   1,
                      import_order_id: 1
                    ))
  end

  # rubocop:disable RSpec/ExampleLength
  it 'renders new artist form' do
    render

    assert_select 'form[action=?][method=?]', artists_path, 'post' do
      assert_select 'textarea[name=?]', 'artist[name]'
      assert_select 'textarea[name=?]', 'artist[sort_name]'
      assert_select 'textarea[name=?]', 'artist[disambiguation]'
      assert_select 'input[name=?]', 'artist[brainz_code]'
      assert_select 'input[name=?]', 'artist[discogs_code]'
      assert_select 'input[name=?]', 'artist[imdb_code]'
      assert_select 'input[name=?]', 'artist[tmdb_code]'
      assert_select 'input[name=?]', 'artist[wikidata_code]'
      assert_select 'input[name=?]', 'artist[import_order_id]'
    end
  end
  # rubocop:enable RSpec/ExampleLength
end
