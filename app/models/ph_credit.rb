class PhCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :piece_head
  belongs_to :job
end
