require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertCompanies, type: :model do
  context 'AC/DC - Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 940_468)
      dc_release = KleinodienDiscogs.get_release(json)
      @release = Discogs::InsertRelease.perform(dc_release)
      @companies = @release.companies
    end

    it 'has set the companies' do
      company = @companies[0]
      expect(company.company.name).to eq('Roundhouse Studios')
      expect(company.company_role.name).to eq('Recorded At')
      expect(company.catalog_no).to eq('')

      company = @companies[1]
      expect(company.company.name).to eq('Basing Street Studios')
      expect(company.company_role.name).to eq('Mixed At')
      expect(company.catalog_no).to eq('')

      company = @companies[2]
      expect(company.company.name).to eq('Sterling Sound')
      expect(company.company_role.name).to eq('Mastered At')
      expect(company.catalog_no).to eq('')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
