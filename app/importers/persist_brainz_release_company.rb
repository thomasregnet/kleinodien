# frozen_string_literal: true

# Persist a Release-Company with data fetched from MusicBrainz
class PersistBrainzReleaseCompany < PersistBrainzBase
  def initialize(blueprint:, release:, **args)
    super(args)
    @blueprint = blueprint
    @code      = blueprint.label.brainz_code
    @release   = release
  end

  def call
    release_catalog_number
    company
  end

  private

  attr_reader :code, :release

  def blueprint
    @blueprint ||= proxy.get(:company, code)
  end

  def company
    @company ||= persist_company(blueprint: blueprint.label)
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
    @release_company ||= ReleaseCompany.find_or_create_by!(
      company: company,
      release: release,
      role:    company_role
    )
  end
end
