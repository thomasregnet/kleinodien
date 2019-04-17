# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe BuildImportOrderFromUriService do
  it_behaves_like 'a service'

  def prefix
    'https://musicbrainz.org'
  end

  def kind
    'release-group'
  end

  def code
    '30be7c55-6388-49d0-83a6-88e4b5602212'
  end

  def uri_string
    [prefix, kind, code].join('/')
  end

  describe 'state' do
    context 'without a given state' do
      let(:import_order) { described_class.call(uri_string: uri_string) }

      it 'returns "pending"' do
        expect(import_order.state).to eq('pending')
      end
    end

    context 'with a given state' do
      let(:import_order) do
        described_class.call(
          uri_string: uri_string,
          state:      'failed'
        )
      end

      it 'sets that state' do
        expect(import_order.state).to eq('failed')
      end
    end
  end

  describe 'uri_string' do
    context 'with a valid uri' do
      let(:import_order) { described_class.call(uri_string: uri_string) }

      it 'returns an ImportOrder object' do
        expect(import_order).to be_instance_of BrainzImportOrder
      end

      it 'has the code set' do
        expect(import_order.code).to eq code
      end

      it 'has the kind set' do
        expect(import_order.kind).to eq kind
      end
    end

    context 'with an invalid uri' do
      let(:import_order) { described_class.call(uri_string: 'wrong') }

      it 'returns nil' do
        expect(import_order).to be_nil
      end
    end
  end

  context 'with an user' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns the ImportOrder with that user set' do
      import_order = described_class.call(uri_string: uri_string, user: user)
      expect(import_order.user).to eq(user)
    end
  end
end
