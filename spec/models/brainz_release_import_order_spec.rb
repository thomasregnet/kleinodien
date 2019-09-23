require 'rails_helper'

RSpec.describe BrainzReleaseImportOrder, type: :model do
  context 'with valid attributes' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order) }

    it 'has the expected ImportQueue set' do
      expect(import_order.import_queue.name).to eq('brainz')
    end
  end
end
