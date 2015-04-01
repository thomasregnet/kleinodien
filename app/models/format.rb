class Format < ActiveRecord::Base
  validates :name, presence: true, blank: false
  validates :type, presence: true, blank: false
  validates_uniqueness_of :name, scope: 'type', case_sensitive: false
end
