# frozen_string_literal: true

# ISO codes for countries deleted form ISO 3166-1
class Iso3166Part3Country < ApplicationRecord
  include Iso3166
  belongs_to :area

  validates(
    :code,
    format: {
      with:    /\A[A-Z]{4}\z/,
      message: 'must consist of four uppercase letters'
    }
  )
end
