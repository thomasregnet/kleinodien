class ReleaseCompany < ApplicationRecord
  belongs_to :company
  belongs_to :company_role
  belongs_to :release
end
