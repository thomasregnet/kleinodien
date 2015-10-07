class PhCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :piece_head
  belongs_to :job
  validates :artist_credit, presence: true
  validates :piece_head, presence: true
end
