# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe PersistBrainzAreaAlias do
  it_behaves_like 'a service'

  describe '.call' do
    context 'with an "Area name"' do
      let(:area) { FactoryBot.create(:area) }
      let(:blueprint) do
        TestData.by_name(:brainz_area_germany).blueprint.aliases[2]
      end

      it 'retuns an AreaNameAlias' do
        expect(described_class.call(area: area, blueprint: blueprint))
          .to be_instance_of(AreaNameAlias)
      end
    end

    context 'with a "Formal name"' do
      let(:area) { FactoryBot.create(:area) }
      let(:blueprint) do
        TestData.by_name(:brainz_area_germany).blueprint.aliases[5]
      end

      it 'retuns an AreaNameAlias' do
        expect(described_class.call(area: area, blueprint: blueprint))
          .to be_instance_of(AreaFormalNameAlias)
      end
    end

    context 'without an Area' do
      let(:blueprint) do
        TestData.by_name(:brainz_area_germany).blueprint.aliases[5]
      end

      it 'retuns an AreaNameAlias' do
        expect { described_class.call(area: nil, blueprint: blueprint) }
          .to raise_error(
            ActiveRecord::RecordInvalid, 'Validation failed: Area must exist'
          )
      end
    end

    context 'without a blueprint' do
      let(:area) { FactoryBot.create(:area) }

      it 'retuns an AreaNameAlias' do
        expect { described_class.call(area: area, blueprint: nil) }
          .to raise_error(NoMethodError)
      end
    end
  end

  describe '#alias_type' do
    context 'with "Area name" as blueprint#type' do
      let(:blueprint) { spy }
      let(:persister) { described_class.new(area: nil, blueprint: blueprint) }

      before { allow(blueprint).to receive(:type).and_return('Area name') }

      it 'returns "AreaNameAlias"' do
        expect(persister.send(:alias_type)).to eq('AreaNameAlias')
      end
    end

    context 'with "Formal name" as blueprint#type' do
      let(:blueprint) { spy }
      let(:persister) { described_class.new(area: nil, blueprint: blueprint) }

      before { allow(blueprint).to receive(:type).and_return('Formal name') }

      it 'returns "AreaFormalNameAlias"' do
        expect(persister.send(:alias_type)).to eq('AreaFormalNameAlias')
      end
    end

    context 'with "Search hint" as blueprint#type' do
      let(:blueprint) { spy }
      let(:persister) { described_class.new(area: nil, blueprint: blueprint) }

      before { allow(blueprint).to receive(:type).and_return('Search hint') }

      it 'returns "AreaSearchHint"' do
        expect(persister.send(:alias_type)).to eq('AreaSearchHint')
      end
    end

    context 'with an invalid blueprint#type' do
      let(:blueprint) { spy }
      let(:persister) { described_class.new(area: nil, blueprint: blueprint) }

      before { allow(blueprint).to receive(:type).and_return('Stuff') }

      it 'returns nil' do
        expect(persister.send(:alias_type)).to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
