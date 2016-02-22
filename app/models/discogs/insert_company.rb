module Discogs
  # Insert a Company from Discogs
  class InsertCompany
    def self.perform(dc_company, album_release)
      new(dc_company, album_release).perform
    end

    def initialize(dc_company, album_release)
      @dc_company    = dc_company
      @album_release = album_release
    end

    def perform
      company = Company.find_or_create_by!(name: @dc_company.name)
      @album_release.companies.create!(
        catalog_no:   @dc_company.catno,
        company:      company,
        company_role: role
      )
    end

    private

    def role
      CompanyRole.find_or_create_by!(name: @dc_company.entity_type_name)
    end
  end
end
