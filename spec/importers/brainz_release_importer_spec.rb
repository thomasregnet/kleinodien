# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe BrainzReleaseImporter do
  before { DatabaseCleaner.start }

  after { DatabaseCleaner.clean }

  let(:import_order) do
    BrainzImportOrder.new(
      code:  '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
      kind:  'release',
      state: 'pending',
      user:  FactoryBot.build(:user)
    )
  end

  describe '.from_import_order' do
    # TODO: Mock out BrainzReleaseImporter#fetch_from_external_data_source
    context 'when the release does not exist' do
      it 'returns an AlbumRelease' do
        expect(described_class.from_import_order(import_order))
          .to be_instance_of AlbumRelease
      end
    end

    context 'when the release is already stored in the database' do
      before do
        DatabaseCleaner.start

        FactoryBot.create(
          :compilation_release,
          brainz_code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
        )
      end

      after { DatabaseCleaner.clean }

      it 'raises an exception' do
        expect { described_class.from_import_order(import_order) }
          .to raise_error ImportError::AlreadyExists
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
