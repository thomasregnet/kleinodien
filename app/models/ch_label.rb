# A Label involved in a CompilationHead
class ChLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :compilation_head

  validates :company, presence: true
  validates :compilation_head, presence: true
end
