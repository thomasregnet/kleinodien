# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'import a single from MusicBrainz', type: :feature do
  describe 'import' do
    before { DatabaseCleaner.start }

    after { DatabaseCleaner.clean }

    let(:import_order) do
      BrainzImportOrder.create!(
        code:  '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a', # Sepultura - Arise
        kind:  'release',
        state: 'pending',
        user:  FactoryBot.create(:user)
      )
    end

    scenario 'import' do
      result = BrainzRootImporter.call(import_order: import_order)
      expect(result).to be_created
    end
  end
end
