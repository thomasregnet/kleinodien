# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'import an enhanced CD from MusicBrainz', type: :feature do
  # rubocop:disable RSpec/BeforeAfterAll
  # rubocop:disable RSpec/InstanceVariable
  before(:all) do
    DatabaseCleaner.start
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)

    # Create an ImportOrder for "Iron Maiden - Powerslave"
    import_order = BrainzImportOrder.create!(
      code:  '58e6a3d6-bbbd-4864-983b-e468a5a1a71c',
      kind:  'release',
      state: 'pending',
      user:  FactoryBot.create(:user)
    )

    @result = BrainzRootImporter.call(import_order: import_order)
  end

  after(:all) { DatabaseCleaner.clean }
  # rubocop:enable RSpec/BeforeAfterAll

  before { visit(album_path(@result.id)) }
  # rubocop:enable RSpec/InstanceVariable

  it 'contains the title' do
    expect(page).to have_content('Powerslave')
  end

  it 'contains the band-name' do
    expect(page).to have_content('Iron Maiden')
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
