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
end
