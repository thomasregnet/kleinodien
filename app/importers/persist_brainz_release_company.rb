# frozen_string_literal: true

# Persist a Release-Company with data fetched from MusicBrainz
class PersistBrainzReleaseCompany < PersistBrainzBase
  def initialize(blueprint:, release:, **args)
    super(**args)
    @blueprint = blueprint
    @code      = blueprint.label.brainz_code
    @release   = release
  end

  def call
    release_company
    release_catalog_number
    company
  end

  private

  attr_reader :blueprint, :code, :release

  def company
    @company ||= persist_company(code: code)
  end

  def company_role
    @company_role ||= CompanyRole.find_or_create_by(name: 'Label')
  end

  def release_catalog_number
    catalog_number = blueprint.catalog_number || return

    ReleaseCatalogNumber.create!(
      code:            catalog_number,
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
