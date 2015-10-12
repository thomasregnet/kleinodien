class ChCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :compilation_release
  belongs_to :job
end
