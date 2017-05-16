# Companies involved in a CompilationHead
class ChCompany < ActiveRecord::Base
  belongs_to :compilation_head
  belongs_to :company
  belongs_to :company_role
end
