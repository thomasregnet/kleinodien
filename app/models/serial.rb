class Serial < ActiveRecord::Base
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :disambiguation, case_sensitive: false
  has_many :seasons, inverse_of: :serial
  has_many :episodes, through: :seasons
end
