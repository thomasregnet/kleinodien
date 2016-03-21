# A Label involved in a CompilationHead
class ChLabel < ActiveRecord::Base
  belongs_to :compilation_head
  belongs_to :company

  validates :company, presence: true
  validates :compilation_head, presence: true
end
