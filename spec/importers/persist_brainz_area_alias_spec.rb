# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PersistBrainzAreaAlias do
  it_behaves_like 'a service'

  describe '.call' do
    let(:default_args) do
      {
        area:         FactoryBot.create(:area),
        import_order: MockImportOrder.new,
        proxy:        FakeProxy.new
      }
    end
    let(:germany) { TestData.by_name(:brainz_area_germany).blueprint }

    context 'with an "Area name"' do
      it 'retuns an AreaNameAlias' do
        args = default_args.merge(blueprint: germany.aliases[2])

        expect(described_class.call(args)).to be_instance_of(AreaNameAlias)
      end
    end

    context 'with a "Formal name"' do
      it 'retuns an AreaNameAlias' do
        args = default_args.merge(blueprint: germany.aliases[5])
        expect(described_class.call(args))
          .to be_instance_of(AreaFormalNameAlias)
      end
    end

    context 'without an Area' do
      it 'retuns an AreaNameAlias' do
        args = default_args.merge(blueprint: germany.aliases[5])
        args[:area] = nil

        expect { described_class.call(args) }
          .to raise_error(
            ActiveRecord::RecordInvalid, 'Validation failed: Area must exist'
          )
      end
    end

    context 'without a blueprint' do
      it 'retuns an AreaNameAlias' do
        args = default_args.merge(blueprint: nil)
        expect { described_class.call(args) }
          .to raise_error(NoMethodError, /undefined method.+for nil:NilClass/)
      end
    end
  end

  describe '#alias_type' do
    let(:blueprint) { spy }
    let(:persister) do
      described_class.new(
        area:         nil,
        blueprint:    blueprint,
        import_order: MockImportOrder.new,
        proxy:        FakeProxy.new
      )
    end

    context 'with "Area name" as blueprint#type' do
      before { allow(blueprint).to receive(:type).and_return('Area name') }

      it 'returns "AreaNameAlias"' do
        expect(persister.send(:alias_type)).to eq('AreaNameAlias')
      end
    end

    context 'with "Formal name" as blueprint#type' do
      before { allow(blueprint).to receive(:type).and_return('Formal name') }

      it 'returns "AreaFormalNameAlias"' do
        expect(persister.send(:alias_type)).to eq('AreaFormalNameAlias')
      end
    end

    context 'with "Search hint" as blueprint#type' do
      before { allow(blueprint).to receive(:type).and_return('Search hint') }

      it 'returns "AreaSearchHint"' do
        expect(persister.send(:alias_type)).to eq('AreaSearchHint')
      end
    end

    context 'with an invalid blueprint#type' do
      before { allow(blueprint).to receive(:type).and_return('Stuff') }

      it 'returns nil' do
        expect(persister.send(:alias_type)).to be_nil
      end
    end
  end
end
