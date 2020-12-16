# frozen_string_literal: true

# Languages and their ISO-639 codes
class Language < ApplicationRecord
  has_many :releases

  validates(
    :iso_code_1,
    length:    { is: 2 },
    allow_nil: true,
    format:    {
      with:    /\A[a-z][a-z]\z/,
      message: 'must consist of two lowercase letters'
    }
  )
  validates(
    :iso_code_2b,
    length:    { is: 3 },
    allow_nil: true,
    format:    {
      with:    /\A[a-z][a-z][a-z]\z/,
      message: 'must consist of three lowercase letters'
    }
  )
  validates(
    :iso_code_2t,
    length:    { is: 3 },
    allow_nil: true,
    format:    {
      with:    /\A[a-z][a-z][a-z]\z/,
      message: 'must consist of three lowercase letters'
    }
  )
  validates(
    :iso_code_3,
    length:    { is: 3 },
    allow_nil: true,
    format:    {
      with:    /\A[a-z][a-z][a-z]\z/,
      message: 'must consist of three lowercase letters'
    }
  )

  validates :name, presence: true
end
