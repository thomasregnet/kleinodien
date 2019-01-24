# PieceRelease Company
class PrCompany < ActiveRecord::Base
  belongs_to :piece
  belongs_to :company
  belongs_to :company_role
end
