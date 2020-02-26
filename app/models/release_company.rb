# frozen_string_literal: true

# Company related to a Release
class ReleaseCompany < ApplicationRecord
  belongs_to :company
  belongs_to(
    :role,
    class_name:  'CompanyRole',
    foreign_key: :company_role_id,
    required:    false
  )
  belongs_to :release

  has_many :catalog_numbers, class_name: 'ReleaseCatalogNumber'

  validates_uniqueness_of(
    :company_id,
    scope: %i[release_id company_role_id]
  )
end
