class PrCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :piece_release
  belongs_to :job
end
