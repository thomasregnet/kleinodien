class SectionFormat < ActiveRecord::Base
  validates :name, presence: true, blank: false
  validates :abbr, presence: true, blank: false
end
