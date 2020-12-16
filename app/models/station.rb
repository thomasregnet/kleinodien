# frozen_string_literal: true

# For example a radio-station, TV-station...
class Station < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :ratings
  validates :name,
            presence:   { message: "name can't be blank" },
            uniqueness: {
              scope:          :disambiguation,
              case_sensitive: false
            }
end
