# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_heads/show', type: :view do
  before do
    assign(:release_head,
           ReleaseHead.create!(
             title:          'my title',
             disambiguation: 'my disambiguation',
             brainz_code:    '0357315e-3409-11eb-af5e-08606e75dc17',
             imdb_code:      222,
             tmdb_code:      333,
             wikidata_code:  444,
             artist_credit:  nil,
             import_order:   nil
           ))
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to match(/my title/)
    expect(rendered).to match(/0357315e-3409-11eb-af5e-08606e75dc17/)
    expect(rendered).to match(/222/)
    expect(rendered).to match(/333/)
    expect(rendered).to match(/444/)
  end

  context 'with two releases' do
    before do
      release_head = FactoryBot.create(:release_head)
      release_head.releases.create!(title: 'first release')
      release_head.releases.create!(title: 'second release')

      assign(:release_head, release_head)
    end

    it 'shows the two releases' do
      render

      expect(rendered).to match(/first release/)
      expect(rendered).to match(/second release/)
    end
  end
end
