# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PrepareBrainzArea do
  it_behaves_like 'a service'

  context 'when the area does not exist' do
    let(:blueprint) do
      blueprint = Object.new
      uuid = '59436488-f5d1-11e9-bb5e-7b417b542be2'

      blueprint.define_singleton_method(:brainz_code) { uuid }
      blueprint.define_singleton_method(:name) { 'Lost Island' }

      blueprint
    end
    let(:proxy) { instance_double('BrainzProxy') }

    it 'foos' do
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
end
