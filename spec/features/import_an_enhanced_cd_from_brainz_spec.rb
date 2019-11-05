# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'import an enhanced CD from MusicBrainz', type: :feature do
  # rubocop:disable RSpec/BeforeAfterAll
  # rubocop:disable RSpec/InstanceVariable
  before(:all) do
    DatabaseCleaner.start
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)

    import_order = BrainzReleaseImportOrder.create!(
      code:  '58e6a3d6-bbbd-4864-983b-e468a5a1a71c',
      state: 'pending',
      user:  FactoryBot.create(:user)
    )

    @id = BrainzImporter.call(import_order: import_order).id
  end

  after(:all) { DatabaseCleaner.clean }
  # rubocop:enable RSpec/BeforeAfterAll

  before { visit(album_path(@id)) }
  # rubocop:enable RSpec/InstanceVariable

  it 'has set the right page-title' do
    expect(page).to have_title('Powerslave')
  end

  it 'contains the title' do
    expect(page).to have_content('Powerslave')
  end

  it 'contains the band-name' do
    expect(page).to have_content('Iron Maiden')
  end

  describe 'release events' do
    it 'contains the first release event' do
      expect(page).to have_content('United Kingdom')
    end

    it 'contains the second release event' do
      expect(page).to have_content('Europe')
    end
  end

  describe 'pieces' do
    it 'contains "Aces High"' do
      expect(page).to have_content('Aces High')
    end

    it 'content "2 Minutes to Midnight (video)"' do
      expect(page).to have_content('2 Minutes to Midnight (video)')
    end
  end
end
# rubocop:enable Metrics/BlockLength
