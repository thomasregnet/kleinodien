require 'rails_helper'
require 'fake_reference'

module Importer
  # Fake a Importer-service class for testing
  class FakeServiceClass < Importer::Base
    def self.perform(args)
      new(args).perform
    end

    def perform
      {
        cache:      cache,
        reference: reference,
        params:     params
      }
    end
  end
end

RSpec.describe Importer::Base do
  def offered
    'abc123'
  end

  def params
    Importer::Offer.new(
      offered: offered,
      type: 'some-test-data'
    ).to_hash
  end

  describe '#data_import' do
    it 'returns an DataImport object'
  end

  describe '#knowledge' do
    let(:base) { described_class.new }

    it 'retuns an Importer::Store object' do
      expect(base.store).to be_instance_of(Importer::Store)
    end
  end

  describe '#params' do
    it 'can take params as an argument' do
      base = described_class.new(params: params)
      expect(base.params).to eq params
    end

    it 'returns the offered id if correct params are given' do
      base = described_class.new(params: params)
      expect(base.offered).to eq(offered)
    end

    it 'without params it returns nil for "offered"' do
      base = described_class.new
      expect(base.offered).to be nil
    end
  end

  describe '#reference' do
    it 'returns the reference' do
      reference = { just: 'a fake' }
      base = described_class.new(reference: reference)
      expect(base.reference).to eq reference
    end

    it "generates a reference if it's class is given" do
      base = described_class.new(
        params: params,
        reference_class: FakeReference
      )
      expect(base.reference.code).to eq(offered)
    end
  end

  describe 'method_missing' do
    specify '#respond_to_missing?' do
      base = described_class.new
      expect(base.respond_to?('fake_service_class')).to be true
    end

    it 'does not respond to missing' do
      base = described_class.new
      expect(base.respond_to?(:no_such_class)).to be false
    end
  end
end
