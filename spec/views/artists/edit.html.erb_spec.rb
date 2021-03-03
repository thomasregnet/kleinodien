# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artists/edit', type: :view do
  let(:artist) { FactoryBot.create(:artist) }

  before { assign(:artist, artist) }

  # rubocop:disable RSpec/ExampleLength
  it 'renders the edit artist form' do
    render

    assert_select 'form[action=?][method=?]', artist_path(artist), 'post' do
      assert_select 'textarea[name=?]', 'artist[name]'
      assert_select 'textarea[name=?]', 'artist[sort_name]'
      assert_select 'textarea[name=?]', 'artist[disambiguation]'
      # assert_select 'input[name=?]', 'artist[begin_date]'
      assert_select 'input[name=?]', 'artist[begin_date_mask]'
      # assert_select 'input[name=?]', 'artist[end_date]'
      assert_select 'input[name=?]', 'artist[end_date_mask]'
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
