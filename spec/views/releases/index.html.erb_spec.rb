# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/index', type: :view do
  context 'with one release' do
    before do
      FactoryBot.create(:release, title: 'My Release')
      releases = Release.includes(:artist_credit).page
      assign(:releases, releases)
    end

    it 'displays the release title' do
      render
      expect(rendered).to match(/My Release/)
    end
  end

  context 'with many releases' do
    before do
      FactoryBot.create_list(:release, 26)
      releases = Release.includes(:artist_credit).page
      assign(:releases, releases)
    end

    it 'displays the pagination' do
      render
      expect(rendered).to match(/<nav class="pagination/)
    end
  end
end
