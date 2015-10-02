class Country < ActiveRecord::Base
  validates :name, presence: true, blank: false
  validates_uniqueness_of :name, case_sensitive: false

  #has_many :compilation_releases, through: :compilation_releases_countries
  #has_many :compilation_releases_countries, inverse_of: :country
  has_and_belongs_to_many :compilation_releases
end
