# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_active_import_orders'
require 'shared_examples_for_concrete_import_orders'
require 'shared_examples_for_import_orders'

RSpec.describe BrainzReleaseImportOrder, type: :model do
  it { should respond_to(:item_designation) }

  it_behaves_like 'an active ImportOrder', :brainz_release_import_order
  it_behaves_like 'a concrete ImportOrder'
  it_behaves_like 'an ImportOrder', :brainz_release_import_order

  context 'when state is "done"' do
    let(:code) { 'a01a3ad6-411a-11eb-a740-08606e75dc17' }
    let(:import_order) { described_class.new(code: code, state: :done) }

    before do
      FactoryBot.create(:release, brainz_code: code, title: 'seven of nine')
    end

    describe '#item' do
      it 'returns the release' do
        expect(import_order.item).to be_instance_of(Release)
      end
    end

    describe '#item_designation' do
      it 'returns the release.title' do
        expect(import_order.item_designation).to eq('seven of nine')
      end
    end
  end
end
