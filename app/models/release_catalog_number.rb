# frozen_string_literal: true

# Codes for Releases
class ReleaseCatalogNumber < ApplicationRecord
  belongs_to :release_company

  validates :code, presence: true, blank: false
end
