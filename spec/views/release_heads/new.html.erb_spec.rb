# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_heads/new', type: :view do
  before do
    assign(:release_head, ReleaseHead.new(
                            title:          'my title',
                            disambiguation: 'my disambiguation',
                            brainz_code:    '',
                            imdb_code:      1,
                            tmdb_code:      1,
                            wikidata_code:  1,
                            artist_credit:  nil,
                            import_order:   nil
                          ))
  end

  it 'renders new release_head form' do
    render

    assert_select 'form[action=?][method=?]', release_heads_path, 'post' do
      assert_select 'textarea[name=?]', 'release_head[title]'
      assert_select 'textarea[name=?]', 'release_head[disambiguation]'
      assert_select 'textarea[name=?]', 'release_head[type]'
      assert_select 'input[name=?]', 'release_head[brainz_code]'
      assert_select 'input[name=?]', 'release_head[imdb_code]'
      assert_select 'input[name=?]', 'release_head[tmdb_code]'
      assert_select 'input[name=?]', 'release_head[wikidata_code]'
      assert_select 'input[name=?]', 'release_head[artist_credit_id]'
      assert_select 'input[name=?]', 'release_head[import_order_id]'
    end
  end
end
