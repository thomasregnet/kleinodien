# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'test_data'

RSpec.describe PrepareBrainzLabel do
  def brainz_code
    'f1273178-651b-4d02-8f21-4ab1ec5a689a'
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def stub
    stub = Object.new
    code = brainz_code

    stub.define_singleton_method(:area) {}
    stub.define_singleton_method(:brainz_code) { code }

    stub
  end

  context 'when the Company exists in the database' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:company, brainz_code: brainz_code)
    end

    after { DatabaseCleaner.clean }

    let(:proxy) { FakeProxy.new }

    it 'does not call #get on the proxy' do
      described_class.call(
        import_order: MockImportOrder.new,
        proxy:        proxy,
        stub:         stub
      )

      expect(proxy).not_to be_called_get
    end
  end

  context 'when the Company does not exist in the database' do
    let(:proxy) { FakeProxy.new }
    let(:args) do
      {
        import_order: MockImportOrder.new,
        proxy:        proxy,
        stub:         stub
      }
    end

    it 'does call #get on the proxy' do
      area_preparer = class_double('PrepareBrainzArea')
                      .as_stubbed_const(transfer_nested_constants: true)

      allow(area_preparer).to receive(:call)

      described_class.call(args)

      expect(proxy).to be_called_get
    end
  end

  context 'when the company has no area' do
    let(:preparer) do
      described_class.new(
        import_order: MockImportOrder.new,
        proxy:        FakeProxy.new,
        stub:         TestData.by_name(:brainz_label_noise).blueprint
      )
    end

    it 'does not call PrepareBrainzArea' do
      prepare_brainz_area = class_spy(PrepareBrainzArea)
      stub_const('PrepareBrainzArea', prepare_brainz_area)
      preparer.call
      expect(prepare_brainz_area).not_to have_received(:call)
    end
  end
end
