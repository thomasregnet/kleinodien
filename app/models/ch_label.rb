# A Label involved in a CompilationHead
class ChLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :compilation_head
end
