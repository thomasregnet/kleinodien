# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'import a single from MusicBrainz', type: :feature do
  # rubocop:disable RSpec/BeforeAfterAll
  # rubocop:disable RSpec/InstanceVariable
  before(:all) do
    DatabaseCleaner.start
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)

    import_order = BrainzImportOrder.create!(
      code:  '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a', # Sepultura - Arise
      kind:  'release',
      state: 'pending',
      user:  FactoryBot.create(:user)
    )

    @result = BrainzRootImporter.call(import_order: import_order)
  end

  after(:all) { DatabaseCleaner.clean }
  # rubocop:enable RSpec/BeforeAfterAll

  before { visit(single_path(@result.id)) }
  # rubocop:enable RSpec/InstanceVariable

  it 'has set the right page-title' do
    expect(page).to have_title('Arise')
  end

  it 'contains the title' do
    expect(page).to have_text('Arise')
  end

  it 'contains the band-name' do
    expect(page).to have_text('Sepultura')
  end

  it 'contains "Troops of Doom (live)"' do
    expect(page).to have_content('Troops of Doom (live)')
  end
end
