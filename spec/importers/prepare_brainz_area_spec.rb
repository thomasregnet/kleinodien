# frozen_string_literal: true

require 'fake_proxy'
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
  def blueprint
    blueprint = Object.new
    brainz_code = '59436488-f5d1-11e9-bb5e-7b417b542be2'

    blueprint.define_singleton_method(:brainz_code) { brainz_code }
    blueprint.define_singleton_method(:name) { "Helm's Deep" }

    blueprint
  end

  context 'when the area does not exist' do
    let(:proxy) { instance_double('BrainzProxy') }

    it 'triggers the proxy' do
      preparer = described_class.new(
        blueprint:    blueprint,
        import_order: FactoryBot.create(:brainz_release_import_order),
        proxy:        proxy
      )
      allow(proxy).to receive(:get)
      preparer.prepare
      expect(proxy).to have_received(:get)
        .with(instance_of(BrainzAreaImportRequest))
    end
  end

  context 'when an Area with the same brainz_code exists' do
    # let(:proxy) { spy }
    let(:proxy) { FakeProxy.new }

    before { FactoryBot.create(:area, brainz_code: brainz_code) }

    it 'does not trigger the proxy' do
      preparer = described_class.new(
        blueprint:    blueprint,
        import_order: FactoryBot.create(:brainz_release_import_order),
        proxy:        proxy
      )
      preparer.prepare
      expect(proxy).not_to have_received_get
    end
  end

  context 'when an Area with the same name exists' do
    let(:name) { "Helm's Deep" }
    let(:proxy) { FakeProxy.new }

    before { FactoryBot.create(:area, name: name) }

    it 'does not trigger the proxy' do
      preparer = described_class.new(
        blueprint:    blueprint,
        import_order: FactoryBot.create(:brainz_release_import_order),
        proxy:        proxy
      )
      preparer.prepare
      expect(proxy).not_to have_received_get
    end
  end
end
