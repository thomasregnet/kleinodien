# frozen_string_literal: true

# ISO-3166 codes for provinces or states of a country
class Iso3166Part2Country < ApplicationRecord
  include Iso3166
  belongs_to :area

  validates(
    :code,
    format: {
      with:    /\A[A-Z]{2}-[A-Z0-9]{1,3}/,
      message: 'must look like AA-123'
    }
  )
end
