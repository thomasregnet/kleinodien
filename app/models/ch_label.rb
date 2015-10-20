class ChLabel < ActiveRecord::Base
  belongs_to :compilation_head
  belongs_to :company
end
