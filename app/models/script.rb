# frozen_string_literal: true

# ISO 15924 script
class Script < ApplicationRecord
  validates(
    :iso_code,
    length:   { is: 4 },
    presence: true,
    format:   {
      with:    /\A[A-z][a-z][a-z][a-z]\z/,
      message: 'must consist of an uppercase letter' \
       + ' followed by three lowercase letters'
    }
  )
  validates :name, presence: true
end
