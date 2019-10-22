# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe FindAreaByNameService do
  it_behaves_like 'a service'

  context 'when the name exists nowhere' do
    it 'returns nothing' do
      expect(described_class.call(name: 'no such area')).to be_nil
    end
  end

  context 'when an area with that name exists' do
    before { Area.create(name: 'expected area') }

    it 'returns that area' do
      expect(described_class.call(name: 'expected area').name)
        .to eq('expected area')
    end
  end

  context 'when an Iso3166Part1Country with that code exists' do
    let(:name) { 'XY' }

    before do
      FactoryBot.create(:iso3166_part1_country, code: name)
    end

    it 'returns an Area' do
      expect(described_class.call(name: name)).to be_instance_of(Area)
    end
  end

  context 'when an Iso3166Part2Country with that code exists' do
    let(:name) { 'XY-Z' }

    before do
      FactoryBot.create(:iso3166_part2_country, code: name)
    end

    it 'returns an Area' do
      expect(described_class.call(name: name)).to be_instance_of(Area)
    end
  end

  context 'when an Iso3166Part3Country with that code exists' do
    let(:name) { 'ABCD' }

    before do
      FactoryBot.create(:iso3166_part3_country, code: name)
    end

    it 'returns an Area' do
      expect(described_class.call(name: name)).to be_instance_of(Area)
    end
  end
end
