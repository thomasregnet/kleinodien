# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrainzReleaseImporter do
  before { DatabaseCleaner.start }

  after { DatabaseCleaner.clean }

  describe '.from_import_order' do
    context 'when the release does not exist' do
      let(:import_order) do
        BrainzImportOrder.new(
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
          kind: 'release',
          state: 'pending',
          user: FactoryBot.build(:user)
        )
      end

      describe '.from_import_order' do
        it 'returns an AlbumRelease' do
          expect(described_class.from_import_order(import_order))
            .to be_instance_of AlbumRelease
        end
      end
    end
  end
end
