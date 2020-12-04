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

    context 'with a catalog_number' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_eaten_back_to_life)
                .blueprint
                .label_infos[0]
      end

      let(:release_company) do
        described_class.call(
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_release_import_order),
          proxy:        FakeProxy.new,
          release:      FactoryBot.create(:release)
        ).release_companies.first
      end

      it 'has the expected ReleaseCatalogNumber' do
        expect(release_company.catalog_numbers.first.code).to eq('CAROL CD 1900')
      end
    end

    context 'without a catalog_number' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_eaten_back_to_life)
                .blueprint
                .label_infos[1]
      end

      let(:release_company) do
        described_class.call(
          blueprint:    blueprint,
          import_order: FactoryBot.create(:brainz_release_import_order),
          proxy:        FakeProxy.new,
          release:      FactoryBot.create(:release)
        ).release_companies.first
      end

      it 'has no ReleaseCatalogNumber' do
        expect(release_company.catalog_numbers.length).to eq(0)
      end
    end
  end
end
