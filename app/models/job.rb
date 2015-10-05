class Job < ActiveRecord::Base
  validates :name, presence: true, blank: false
  validates_uniqueness_of :name, case_sensitive: false
end
