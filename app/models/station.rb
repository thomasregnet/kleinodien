# For example a radio-station, TV-station...
class Station < ActiveRecord::Base
  has_many :comments
  validates :name,
            presence: true,
            uniqueness: {
              scope:          :disambiguation,
              case_sensitive: false
            }
end
