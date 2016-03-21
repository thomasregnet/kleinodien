# What an Artist contributed
class Job < ActiveRecord::Base
  validates :name,
            presence:   true,
            blank:      false,
            uniqueness: { case_sensitive: false }
end
