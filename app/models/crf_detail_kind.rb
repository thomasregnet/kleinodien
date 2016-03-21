# Detail of a ComplationRelease.format
class CrfDetailKind < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
