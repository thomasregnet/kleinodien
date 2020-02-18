# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrepareBrainzCompany do
  def brainz_code
    'f1273178-651b-4d02-8f21-4ab1ec5a689a'
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def blueprint
    blueprint = Object.new
    code      = brainz_code

    blueprint.define_singleton_method(:brainz_code) { code }
    blueprint.define_singleton_method(:name) { 'Alternative Tentacles' }

    blueprint
  end

  context 'when the Company exists in the database' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:company, brainz_code: brainz_code)
    end

    after { DatabaseCleaner.clean }

    let(:proxy) { spy }

    it 'does not call #get on the proxy' do
      described_class.call(
        blueprint:    blueprint,
        import_order: :fake_import_order,
        proxy:        proxy
      )

      expect(proxy).not_to have_received(:get)
    end
  end

  context 'when the Company does not exist in the database' do
    let(:proxy) { spy }

    it 'does not call #get on the proxy' do
      described_class.call(
        blueprint:    blueprint,
        import_order: :fake_import_order,
        proxy:        proxy
      )

      expect(proxy).to have_received(:get)
    end
  end
end
