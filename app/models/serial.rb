class Serial < ActiveRecord::Base
  has_many :seasons, inverse_of: :serial
  has_many :episodes, through: :seasons

  validates :title, presence: true
  validates_uniqueness_of :title,
                          scope: :disambiguation,
                          case_sensitive: false
end
