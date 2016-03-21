# Company, for example a label
class Company < ActiveRecord::Base
  validates :name,
            presence:   true,
            blank:      false,
            uniqueness: { case_sensitive: false }
end
