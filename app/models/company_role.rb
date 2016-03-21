# A CompanyRole may be for example a copyright or a distibution
class CompanyRole < ActiveRecord::Base
  validates :name,
            presence: true,
            blank: false,
            uniqueness: { case_sensitive: false }
end
