class Country < ActiveRecord::Base
  validates :name, presence: true, blank: false
  validates_uniqueness_of :name, case_sensitive: false

  has_and_belongs_to_many :compilation_releases
  has_and_belongs_to_many :piece_heads
  has_and_belongs_to_many :piece_releases
end
