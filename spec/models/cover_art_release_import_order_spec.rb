# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_active_import_orders'
require 'shared_examples_for_import_orders'

RSpec.describe CoverArtReleaseImportOrder, type: :model do
  it { should respond_to(:item_designation) }

  it_behaves_like 'an active ImportOrder', :cover_art_release_import_order

  it_behaves_like 'an ImportOrder', :cover_art_release_import_order

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
      let(:cover_art_code) { '50cdde32-1ed4-11eb-be0c-08606e75dc17' }
      let(:import_order) { described_class.new(code: :cover_art_code, state: :done) }

      before do
        import_order.code = cover_art_code
        FactoryBot.create(:release, brainz_code: cover_art_code)
      end

      it 'returns a release' do
        expect(import_order.item).to be_instance_of(Release)
      end
    end
  end
end
