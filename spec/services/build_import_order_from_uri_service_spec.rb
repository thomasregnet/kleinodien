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

  context 'with a valid uri' do
    let(:import_order) { described_class.call(uri_string) }

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
end
