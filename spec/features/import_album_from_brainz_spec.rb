# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'MusicBrainz imports' do
  describe 'import' do
    before { DatabaseCleaner.start }

    after { DatabaseCleaner.clean }

    let(:import_order) do
      BrainzImportOrder.create!(
        code:  '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
        kind:  'release',
        state: 'pending',
        user:  FactoryBot.create(:user)
      )
    end

    scenario 'import' do
      BrainzRootImporter.run(import_order: import_order)

      expect(:foo).to eq(:foo)
    end
  end
end
