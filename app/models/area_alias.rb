# frozen_string_literal: true

# Aliases for areas
class AreaAlias < ApplicationRecord
  belongs_to :area

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
