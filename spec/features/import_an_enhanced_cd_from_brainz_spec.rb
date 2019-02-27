# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'import an enhanced CD from MusicBrainz' do
  describe 'import' do
    before { DatabaseCleaner.start }

    after { DatabaseCleaner.clean }

    let(:import_order) do
      # Create an ImportOrder for "Iron Maiden - Powerslave"
      BrainzImportOrder.create!(
        code:  '58e6a3d6-bbbd-4864-983b-e468a5a1a71c',
        kind:  'release',
        state: 'pending',
        user:  FactoryBot.create(:user)
      )
    end

    scenario 'run the import' do
      result = BrainzRootImporter.call(import_order: import_order)
      expect(result).to be_created
    end
  end
end
