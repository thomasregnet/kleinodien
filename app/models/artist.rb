class Artist < ActiveRecord::Base
  has_many :participants, inverse_of: :artist

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :disambiguation, case_sensitive: false
end
