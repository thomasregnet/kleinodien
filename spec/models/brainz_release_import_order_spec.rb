# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_active_import_orders'
require 'shared_examples_for_import_orders'

RSpec.describe BrainzReleaseImportOrder, type: :model do
  it { should respond_to(:item_designation) }

  it_behaves_like 'an active ImportOrder', :brainz_release_import_order
  it_behaves_like 'an ImportOrder', :brainz_release_import_order

  context 'with valid attributes' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order) }

    it 'is valid' do
      expect(import_order).to be_valid
    end
  end

  context 'without an queue_name' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order) }

    it 'sets the default value' do
      import_order.import_queue = nil
      import_order.valid?

      expect(import_order.import_queue.name).to eq('brainz')
    end
  end

  describe '#item' do
    %i[pending preparing persisting failed].each do |state|
      import_order = described_class.new(state: state)

      context "when #{state}" do
        it 'returns nil' do
          expect(import_order.item).to be_nil
        end

        it 'does not try to find a Release' do
          allow(Release).to receive(:find_by)
          import_order.item
          expect(Release).not_to have_received(:find_by)
        end
      end
    end

    context 'when done' do
      let(:brainz_code) { '50cdde32-1ed4-11eb-be0c-08606e75dc17' }
      let(:import_order) { described_class.new(code: :brainz_code, state: :done) }

      before do
        import_order.code = brainz_code
        FactoryBot.create(:release, brainz_code: brainz_code)
      end

      it 'returns a release' do
        expect(import_order.item).to be_instance_of(Release)
      end
    end

    describe '#cover_art_import_order' do
      let(:import_order) { FactoryBot.create(:brainz_release_import_order) }

      before do
        import_order.cover_art_release_import_order = FactoryBot.create(:cover_art_release_import_order)
        import_order.save!
      end

      it 'adds an CoverArtImportOrder' do
        expect(import_order.cover_art_release_import_order.id).not_to be_nil
      end

      it 'does not set the import_order_id' do
        expect(import_order.import_order_id).to be_nil
      end
    end
  end
end
