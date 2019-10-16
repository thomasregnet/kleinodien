# frozen_string_literal: true

# ISO-3166 1 Country codes and their Area
class Iso3166Part1Country < ApplicationRecord
  belongs_to :area

  validates(
    :code,
    blank:    false,
    format:   {
      with:    /\A[A-Z]{2}\z/,
      message: 'must consist of two capital letters'
    },
    presence: true
  )
end
