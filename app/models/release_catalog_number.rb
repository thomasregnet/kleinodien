# frozen_string_literal: true

# Codes for Releases
class ReleaseCatalogNumber < ApplicationRecord
  belongs_to :release_company

  validates :code, presence: true
  validates(
    :code,
    uniqueness: { case_sensitive: false, scope: :release_company_id }
  )
end
