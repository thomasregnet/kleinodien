# PieceHead Company
class PhCompany < ActiveRecord::Base
  belongs_to :piece_head
  belongs_to :company
  belongs_to :company_role
end
