class CompanyRole < ActiveRecord::Base
  validates :name, presence: true, blank: false
end
