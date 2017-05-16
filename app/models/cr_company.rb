# A Company involvend in a CompilationRelease
class CrCompany < ActiveRecord::Base
  belongs_to :company
  belongs_to :company_role
  belongs_to :compilation_release
end
