# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PrepareBrainzArea do
  it_behaves_like 'a service'

  def brainz_code
    '59436488-f5d1-11e9-bb5e-7b417b542be2'
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:UtilityFunction
  def stub
    blueprint = Object.new
    brainz_code = '59436488-f5d1-11e9-bb5e-7b417b542be2'

    blueprint.define_singleton_method(:brainz_code) { brainz_code }
    blueprint.define_singleton_method(:name) { "Helm's Deep" }

    blueprint
  end

  context 'when the area does not exist' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order) }
    let(:proxy) { instance_double('BrainzProxy') }

    it 'triggers the proxy' do
      preparer = described_class.new(
        import_order: import_order,
        proxy:        proxy,
        stub:         stub
      )
      allow(proxy).to receive(:cached?)
      allow(proxy).to receive(:get)
      preparer.prepare
      expect(proxy).to have_received(:get)
        .with(:area, instance_of(String))
    end
  end

  describe 'with an already existing Area' do
    let(:proxy) { FakeProxy.new }

    context 'when an Area with the same brainz_code exists' do
      before { FactoryBot.create(:area, brainz_code: brainz_code) }

      it 'does not trigger the proxy' do
        preparer = described_class.new(
          import_order: MockImportOrder.new,
          proxy:        proxy,
          stub:         stub
        )
        preparer.prepare
        expect(proxy).not_to be_requested
      end
    end

    context 'when an Area with the same name exists' do
      let(:name) { "Helm's Deep" }

      before { FactoryBot.create(:area, name: name) }

      it 'does not trigger the proxy' do
        preparer = described_class.new(
          import_order: MockImportOrder.new,
          proxy:        proxy,
          stub:         stub
        )
        preparer.prepare
        expect(proxy).not_to be_requested
      end
    end
  end
end
