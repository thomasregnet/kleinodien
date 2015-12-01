class Discogs::InsertCompanies
  def self.perform(dc_companies, album_release)
    new(dc_companies, album_release).perform
  end

  def initialize(dc_companies, album_release)
    @dc_companies  = dc_companies
    @album_release = album_release
  end

  def perform
    companies
  end

  private

  def companies
    @dc_companies.each do |dc_company|
      company(dc_company)
    end
  end
  
  def company(dc_company)
    company = Company.find_or_create_by!(name: dc_company.name)
    @album_release.companies.create!(
      catalog_no:   dc_company.catno,
      company:      company,
      company_role: role(dc_company.entity_type_name)
    )
  end

  def role(entity_type_name)
    CompanyRole.find_or_create_by!(name: entity_type_name)
  end
end
