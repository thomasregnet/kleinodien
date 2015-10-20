class PhLabel < ActiveRecord::Base
  belongs_to :piece_head
  belongs_to :company
end
