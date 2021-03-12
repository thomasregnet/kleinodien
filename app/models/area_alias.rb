# frozen_string_literal: true

# Aliases for areas
class AreaAlias < ApplicationRecord
  include IncompletePeriodable
  belongs_to :area

  before_validation :ensure_sort_name_has_a_value

  validates :name, :sort_name, presence: true

  private

  def ensure_sort_name_has_a_value
    self.sort_name = name unless sort_name
  end
end
