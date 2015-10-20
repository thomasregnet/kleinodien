class PrLabel < ActiveRecord::Base
  belongs_to :piece_release
  belongs_to :company
end
