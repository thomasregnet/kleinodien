# frozen_string_literal: true

# An area or a country
class Area < ApplicationRecord
  before_validation :ensure_sort_name_has_a_value

  validates(
    :name,
    blank:      false,
    presence:   true,
    uniqueness: { case_sensitive: false }
  )
  validates(
    :sort_name,
    blank:      false,
    presence:   true,
    uniqueness: { case_sensitive: false }
  )

  private

  def ensure_sort_name_has_a_value
    self.sort_name = name unless sort_name
  end
end
