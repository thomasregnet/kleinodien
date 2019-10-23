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

      blueprint.define_singleton_method(:code) { uuid }
      blueprint.define_singleton_method(:name) { 'Lost Island' }

      blueprint
    end
    let(:proxy) { instance_double('BrainzProxy') }

    # before do
    #   allow(proxy).to receive(:get).with(blueprint)
    # end

    it 'foos' do
      preparer = described_class.new(
        blueprint: blueprint,
        import_order: :fake_import_order,
        proxy:     proxy
      )
      # expect(preparer.prepare).to be_nil
      expect(proxy).to receive(:get)
      preparer.prepare
    end
  end
end
