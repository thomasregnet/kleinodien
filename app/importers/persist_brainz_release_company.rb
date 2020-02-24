# frozen_string_literal: true

# Persist a Release-Company with data fetched from MusicBrainz
class PersistBrainzReleaseCompany < PersistBrainzBase
  def initialize(blueprint:, release:, **args)
    super(args)
    @blueprint = blueprint
    @release   = release
  end

  def call
    # TODO: reactivate when PrepareBrainzReleaseCompany is implemented
    # release_catalog_number

    # company
  end

  private

  attr_reader :blueprint, :release

  def company
    @company ||= PersistBrainzCompany.call(
      blueprint:    company_blueprint,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def company_blueprint
    import_request = BrainzCompanyImportRequest.new(code: blueprint.label.id)
    proxy.get(import_request)
  end

  def company_role
    @company_role ||= CompanyRole.find_or_create_by(name: 'Label')
  end

  def release_catalog_number
    ReleaseCatalogNumber.create!(
      code:            blueprint.catalog_number,
      release_company: release_company
    )
  end

  def release_company
    @release_company ||= ReleaseCompany.create!(
      company: company,
      role:    company_role
    )
  end
end
