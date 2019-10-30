# frozen_string_literal: true

# When a Release was released in an Area
class ReleaseEvent < ApplicationRecord
  belongs_to :release
  belongs_to :area

  composed_of(
    :date,
    allow_nil:  true,
    class_name: 'IncompleteDate',
    mapping:    [%w[date date], %w[date_mask mask]]
  )
end
