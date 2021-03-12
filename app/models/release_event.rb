# frozen_string_literal: true

# When a Release was released in an Area
class ReleaseEvent < ApplicationRecord
  include IncompleteDateable

  belongs_to :release
  belongs_to :area
end
