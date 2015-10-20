class PhLabel < ActiveRecord::Base
  belongs_to :piece_head
  belongs_to :company
  validates :company, presence: true
  validates :piece_head, presence: true
end
