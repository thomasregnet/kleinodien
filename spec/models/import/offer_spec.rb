# frozen_string_literal: true

require 'rails_helper'
require 'fake_reference'

RSpec.describe Import::Offer do
  subject(:offer) { described_class.new(offered: '123', type: :some_type) }

  it { is_expected.to respond_to(:known).with(0).argument }
  it { is_expected.to respond_to(:offered).with(0).argument }
  it { is_expected.to respond_to(:type).with(0).argument }

  describe '#offered' do
    it 'returns the offered id' do
      expect(offer.offered).to eq('123')
    end
  end

  describe '#to_hash' do
    describe '[data][attributes][offered]' do
      it 'returns the offered id' do
        expect(offer.to_hash.dig(:data, :attributes, :offered))
          .to eq('123')
      end
    end
  end
  describe '#type' do
    it 'returns the type' do
      expect(offer.type).to eq(:some_type)
    end
  end

  context 'without knowledge' do
    describe '#known' do
      it 'returns an empty hash' do
        expect(offer.known).to be_instance_of(Import::OfferKnowledge)
      end
    end
  end

  describe '#teach' do
    it 'yields an instance of Import::OfferKnowledge' do
      expect { |knowledge| offer.teach(&knowledge) }
        .to yield_successive_args(Import::OfferKnowledge)
    end
  end

  context 'without knowledge' do
    describe '#to_hash[data]' do
      it 'returns a hash' do
        expect(offer.to_hash[:data]).to be_instance_of(Hash)
      end
    end
  end

  context 'with knowledge' do
    let(:key) { FakeReference.new(code: 'xxx').to_key }
    let(:offer) do
      offer = described_class.new(offered: 'abc, type: :other_type')
      offer.teach do |knowledge|
        knowledge.add_with_reference(
          FakeReference.new(code: 'xxx'), '<fake data>'
        )
      end

      offer
    end

    describe '#to_data[data][attributes][known]' do
      it 'returns the knowledge' do
        expect(
          offer.to_hash.dig(
            :data, :attributes, :known, :fake_catagory, key
          )
        ).to eq('<fake data>')
      end
    end
  end
end
