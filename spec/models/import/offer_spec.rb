require 'rails_helper'

RSpec.describe Import::Offer do
  subject(:offer) { described_class.new(offered: '123', type: :some_type) }

  it { is_expected.to respond_to(:known).with(0).argument }
  it { is_expected.to respond_to(:offered).with(0).argument }
  it { is_expected.to respond_to(:type).with(0).argument }

  context 'without knowledge' do
    describe '#offered' do
      it 'returns the offered id' do
        expect(offer.offered).to eq('123')
      end
    end

    describe '#type' do
      it 'returns the type' do
        expect(offer.type).to eq(:some_type)
      end
    end

    describe '#known' do
      it 'returns an empty hash' do
        expect(offer.known).to be_instance_of(Hash)
      end
    end
  end
end
