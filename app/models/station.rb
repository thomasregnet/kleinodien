# For example a radio-station, TV-station...
class Station < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :descriptions
  has_many :ratings
  validates :name,
            presence: true,
            uniqueness: {
              scope:          :disambiguation,
              case_sensitive: false
            }
end
