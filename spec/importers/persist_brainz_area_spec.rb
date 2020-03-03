# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzArea do
  it_behaves_like 'a service'

  describe 'persists the area' do
    let(:brainz_area) { TestData.by_name(:brainz_area_germany).blueprint }
    let(:import_order) { FactoryBot.build(:brainz_release_import_order) }
    let(:proxy) { FakeProxy.new }

    before do
      described_class.call(
        blueprint:    brainz_area,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'has persisted the area' do
      expect(Area.find_by(name: 'Germany').name).to eq('Germany')
    end

    it 'has persisted the ImportOrder' do
      expect(Area.find_by(name: 'Germany').import_order)
        .to be_instance_of(BrainzReleaseImportOrder)
    end

    it 'returns the right instance-type' do
      expect(Area.find_by(name: 'Germany')).to be_instance_of(Country)
    end
  end

  describe 'iso codes' do
    let(:brainz_area) { TestData.by_name(:brainz_area_germany).blueprint }
    let(:import_order) { FactoryBot.build(:brainz_release_import_order) }
    let(:proxy) { FakeProxy.new }

    let(:area) do
      described_class.call(
        blueprint:    brainz_area,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'has persisted the iso=3166-1-code' do
      expect(area.iso3166_part1_countries.first.code).to eq('DE')
    end
  end
end
