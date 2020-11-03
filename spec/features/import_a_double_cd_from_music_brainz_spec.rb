# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'import a double cd from MusicBrainz', type: :feature do
  # Well, maybe not realy a feature-spec because it makes no use
  # of capybara
  def import_order
    BrainzReleaseImportOrder.create(
      code:  '5831cd39-8f80-3195-baad-1e826140ec6c',
      state: 'pending',
      user:  FactoryBot.create(:user)
    )
  end

  def release
    @release ||= BrainzImporter.call(import_order: import_order)
  end

  # rubocop:disable RSpec/BeforeAfterAll
  before(:all) do
    DatabaseCleaner.start
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)
  end

  after(:all) { DatabaseCleaner.clean }
  # rubocop:enable RSpec/BeforeAfterAll

  it 'has set the artit_credit' do
    expect(release.artist_credit.name).to eq('AC/DC')
  end

  it 'has set the title' do
    expect(release.title).to match(/Live \(special collector.s edition\)/)
  end

  it 'has created two subsets' do
    expect(release.subsets.length).to eq(2)
  end
end
