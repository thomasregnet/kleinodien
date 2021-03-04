# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'release_copies/show', type: :view do
  let(:artist_credit) { FactoryBot.build(:artist_credit, name: 'wonderful artist') }
  let(:release_copy) { FactoryBot.create(:release_copy) }

  before do
    assign(:release_copy, release_copy)
  end

  it 'links to the release' do
    allow(release_copy).to receive(:title).and_return('my title')
    render
    expect(rendered).to have_link('my title')
  end

  it 'renders the #artist_credit' do
    allow(release_copy).to receive(:artist_credit).and_return(artist_credit)
    render
    expect(rendered).to match(/by wonderful artist/)
  end

  it 'renders the #designation as title' do
    allow(release_copy).to receive(:designation).and_return('my designation')
    render
    expect(rendered).to match(/<h1 class="title">\s*my designation/)
  end

  it 'renders the #title as subtitle' do
    allow(release_copy).to receive(:title).and_return('my title')
    render
    expect(rendered).to match(/class="subtitle is-5">.+my title/m)
  end
end
