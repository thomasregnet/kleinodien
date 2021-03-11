# frozen_string_literal: true

# Aliases for areas
class AreaAlias < ApplicationRecord
  belongs_to :area

  # composed_of(
  #   :begin_date,
  #   allow_nil:  true,
  #   class_name: 'IncompleteDate',
  #   mapping:    [%w[begin_date date], %w[begin_date_mask mask]]
  # )
  # composed_of(
  #   :end_date,
  #   allow_nil:  true,
  #   class_name: 'IncompleteDate',
  #   mapping:    [%w[end_date date], %w[end_date_mask mask]]
  # )

  before_validation :ensure_sort_name_has_a_value

  validates :name, :sort_name, presence: true

  private

  def ensure_sort_name_has_a_value
    self.sort_name = name unless sort_name
  end
end
