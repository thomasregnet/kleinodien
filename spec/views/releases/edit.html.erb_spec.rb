require 'rails_helper'

RSpec.describe 'releases/edit', type: :view do
  let(:release) do
    Release.create!(
      title:         'MyText',
      barcode:       1,
      date_mask:     1,
      version:       'MyText',
      brainz_code:   '',
      discogs_code:  1,
      imdb_code:     1,
      tmdb_code:     1,
      wikidata_code: 1,
      area:          nil,
      artist_credit: nil,
      import_order:  nil,
      language:      nil,
      head:          FactoryBot.create(:release_head),
      script:        nil
    )
  end

  before { assign(:release, release) }

  it 'renders the edit release form' do
    render

    assert_select 'form[action=?][method=?]', release_path(release), 'post' do
      assert_select 'textarea[name=?]', 'release[title]'
      assert_select 'input[name=?]', 'release[barcode]'
      assert_select 'input[name=?]', 'release[date_mask]'
      assert_select 'textarea[name=?]', 'release[type]'
      assert_select 'textarea[name=?]', 'release[version]'
      assert_select 'input[name=?]', 'release[brainz_code]'
      assert_select 'input[name=?]', 'release[discogs_code]'
      assert_select 'input[name=?]', 'release[imdb_code]'
      assert_select 'input[name=?]', 'release[tmdb_code]'
      assert_select 'input[name=?]', 'release[wikidata_code]'
      assert_select 'input[name=?]', 'release[area_id]'
      assert_select 'input[name=?]', 'release[artist_credit_id]'
      assert_select 'input[name=?]', 'release[import_order_id]'
      assert_select 'input[name=?]', 'release[language_id]'
      assert_select 'input[name=?]', 'release[release_head_id]'
      assert_select 'input[name=?]', 'release[script_id]'
    end
  end
end
