# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'test_data'

RSpec.describe PersistBrainzReleaseCompany do
  describe 'persist the Company' do
    # rubocop:disable RSpec/BeforeAfterAll
    before(:all) do
      DatabaseCleaner.start

      blueprint    = TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
                             .blueprint
                             .label_infos
                             .first
      import_order = FactoryBot.create(:brainz_release_import_order)

      @company = described_class.call(
        blueprint:    blueprint,
        import_order: import_order,
        proxy:        FakeProxy.new,
        release:      FactoryBot.create(:release)
      )
    end

    after(:all) { DatabaseCleaner.clean }
    # rubocop:enable RSpec/BeforeAfterAll

    # rubocop:disable RSpec/InstanceVariable
    it 'has persisted the company' do
      expect(@company).to be_instance_of(Company)
    end

    it 'has set the ImportOrder' do
      expect(@company.import_order).to be_instance_of(BrainzReleaseImportOrder)
    end

    it 'has persisted the area' do
      expect(@company.area.name).to eq('San Francisco')
    end
    # rubocop:enable RSpec/InstanceVariable
  end
end
