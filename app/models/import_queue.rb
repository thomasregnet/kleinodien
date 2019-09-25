# frozen_string_literal: true

# ImportQueue holds the import_orders of a specific source, e.g. Discogs
class ImportQueue < ApplicationRecord
  has_many :import_orders

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

  def self.next_pending_for(name)
    orders = find_or_create_by(name: name)
             .import_orders.where(state: 'pending')
             .order('created_at asc').limit(1)

    return if orders.empty?

    orders.first
  end
end
