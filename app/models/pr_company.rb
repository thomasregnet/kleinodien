class PrCompany < ActiveRecord::Base
  belongs_to :piece_release
  belongs_to :company
  belongs_to :company_role
end
