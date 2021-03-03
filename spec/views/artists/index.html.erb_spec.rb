# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'artists/index', type: :view do
  context 'with one artist' do
    before do
      FactoryBot.create(:artist, name: 'My Artist', disambiguation: 'My disambiguation')
      artists = Artist.all.page
      assign(:artists, artists)
    end

    it 'displays the artist' do
      render
      expect(rendered).to match(/My Artist.+My disambiguation/m)
    end
  end

  context 'with many artists' do
    before do
      FactoryBot.create_list(:artist, 26)
      artists = Artist.all.page
      assign(:artists, artists)
    end

    it 'displays the pagination' do
      render
      expect(rendered).to match(/<nav class="pagination/)
    end
  end
end
