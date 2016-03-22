# Base class for serials like TV-serials or podcast-serials
class Serial < ActiveRecord::Base
  has_many :seasons, inverse_of: :serial
  has_many :episodes, through: :seasons

  validates :title,
            presence: true,
            uniqueness: {
              scope:          :disambiguation,
              case_sensitive: false
            }
end
