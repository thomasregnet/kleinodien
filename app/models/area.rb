# frozen_string_literal: true

# An area or a country
class Area < ApplicationRecord
  include IncompletePeriodable

  belongs_to :import_order, required: false

  has_many :companies
  has_many :iso3166_part1_countries
  has_many :iso3166_part2_countries
  has_many :iso3166_part3_countries
  has_many :release_events
  has_many :releases

  before_validation :ensure_sort_name_has_a_value

  validates(
    :name,
    presence:   true,
    uniqueness: { case_sensitive: false }
  )
  validates(
    :sort_name,
    presence:   true,
    uniqueness: { case_sensitive: false }
  )

  def iso3166_part1_codes
    iso3166_part1_countries.map(&:code)
  end

  private

  def ensure_sort_name_has_a_value
    self.sort_name = name unless sort_name
  end
end
