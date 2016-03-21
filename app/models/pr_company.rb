# PieceRelease Company
class PrCompany < ActiveRecord::Base
  belongs_to :piece_release
  belongs_to :company
  belongs_to :company_role
  validates :company, presence: true
  validates :company_role, presence: true
  validates :piece_release, presence: true
end
