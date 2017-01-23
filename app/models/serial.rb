# Base class for serials like TV-serials or podcast-serials
class Serial < ActiveRecord::Base
  has_many :comments
  has_many :episodes, through: :seasons
  has_many :seasons, inverse_of: :serial
  has_many :ratings

  validates :title,
            presence: true,
            uniqueness: { scope: :disambiguation, case_sensitive: false }
end
