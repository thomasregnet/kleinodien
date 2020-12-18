# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

RSpec.describe ImportOrder, type: :model do
  it_behaves_like 'an ImportOrder', :import_order

  describe '#uri' do
    context 'with only an uri' do
      def code
        '88c27b7d-83e3-4568-8724-fafbee54f05a'
      end

      let(:import_order) do
        uri = "https://musicbrainz.org/ws/2/release/#{code}/"
        described_class.create(uri: uri, user: FactoryBot.create(:user))
      end

      it 'sets the expected code' do
        expect(import_order.code).to eq(code)
      end

      it 'sets the expected type' do
        expect(import_order.type).to eq('BrainzReleaseImportOrder')
      end
    end
  end
end
