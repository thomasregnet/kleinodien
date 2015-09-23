class CrCompany < ActiveRecord::Base
  belongs_to :company
  belongs_to :company_role
  validates :company, presence: true
  validates :company_role, presence: true
end
