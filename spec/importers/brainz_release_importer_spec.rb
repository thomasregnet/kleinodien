# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrainzReleaseImporter do
  before { DatabaseCleaner.start }

  after { DatabaseCleaner.clean }

  context 'nothing exists' do
    let(:import_order) do
      BrainzImportOrder.create!(
        code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
        kind: 'release',
        state: 'pending',
        user: FactoryBot.create(:user)
      )
    end

    describe '.call' do
      it 'returns an AlbumRelease' do
        expect(described_class.call(import_order))
          .to be_instance_of AlbumRelease
      end
    end
  end
end
