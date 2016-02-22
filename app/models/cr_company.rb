class CrCompany < ActiveRecord::Base
  belongs_to :company
  belongs_to :company_role
  belongs_to :compilation_release

  validates :company, presence: true
  validates :company_role, presence: true
  validates :compilation_release, presence: true
end
