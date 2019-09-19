# frozen_string_literal: true

# ImportQueue holds the import_orders of a specific source, e.g. Discogs
class ImportQueue < ApplicationRecord
  validates(
    :name,
    presence:   true,
    blank:      false,
    uniqueness: true,
    format:     {
      with:    /\A[a-z0-9_]+\z/,
      message: 'allows only lower case letters, digits and the underscore'
    }
  )
end
