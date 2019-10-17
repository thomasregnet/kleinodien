# frozen_string_literal: true

# An area or a country
class Area < ApplicationRecord
  has_many :iso3166_part1_countries
  has_many :iso3166_part2_countries
  has_many :iso3166_part3_countries

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
