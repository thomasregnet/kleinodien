# frozen_string_literal: true

# ISO-3166 1 Country codes and their Area
class Iso3166Part1Country < ApplicationRecord
  include Iso3661

  belongs_to :area

  validates(
    :code,
    format: {
      with:    /\A[A-Z]{2}\z/,
      message: 'must consist of two capital letters'
    }
  )
end
