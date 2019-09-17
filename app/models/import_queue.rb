# frozen_string_literal: true

# ImportQueue holds the import_orders of a specific source, e.g. Discogs
class ImportQueue < ApplicationRecord
  validates(
    :name,
    presence:   true,
    blank:      false,
    uniqueness: true
  )
end
