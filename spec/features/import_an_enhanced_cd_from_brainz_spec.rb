# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'import an enhanced CD from MusicBrainz', type: :feature do
  # rubocop:disable RSpec/BeforeAfterAll
  # rubocop:disable RSpec/InstanceVariable
  before(:all) do
    DatabaseCleaner.start
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)

    # FactoryBot.create(:company, brainz_code: 'c029628b-6633-439e-bcee-ed02e8a338f7', name: 'EMI')
    # FactoryBot.create(:area, brainz_code: '8a754a16-0027-3a29-b6d7-2b40ea0481ed')

    import_order = BrainzReleaseImportOrder.create!(
      code:  '58e6a3d6-bbbd-4864-983b-e468a5a1a71c',
      state: 'pending',
      user:  FactoryBot.create(:user)
    )

    release = BrainzImporter.call(import_order: import_order)
    @id = release.id
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

  it 'contains the area' do
    expect(page).to have_content('United Kingdom')
  end

  it 'contains the ISO 3166-1 code of the release-area' do
    expect(page).to have_content('GB')
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
