class ChCompany < ActiveRecord::Base
  belongs_to :compilation_head
  belongs_to :company
  belongs_to :company_role

  validates :compilation_head, presence: true
  validates :company, presence: true
  validates :company_role, presence: true
end
