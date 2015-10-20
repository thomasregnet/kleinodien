class PhCompany < ActiveRecord::Base
  belongs_to :piece_head
  belongs_to :company
  belongs_to :company_role
  validates :company, presence: true
  validates :company_role, presence: true
  validates :piece_head, presence: true
end
