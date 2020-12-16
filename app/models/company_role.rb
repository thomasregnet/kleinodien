# frozen_string_literal: true

# A CompanyRole may be for example a copyright or a distibution
class CompanyRole < ActiveRecord::Base
  has_many :release_companies

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
