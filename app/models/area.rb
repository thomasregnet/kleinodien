# frozen_string_literal: true

# An area or a country
class Area < ApplicationRecord
  belongs_to :import_order, required: false

  has_many :iso3166_part1_countries
  has_many :iso3166_part2_countries
  has_many :iso3166_part3_countries

  composed_of(
    :begin_date,
    class_name: 'IncompleteDate',
    mapping:    [%w[begin_date date], %w[begin_date_mask mask]]
  )
  composed_of(
    :end_date,
    class_name: 'IncompleteDate',
    mapping:    [%w[end_date date], %w[end_date_mask mask]]
  )

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
