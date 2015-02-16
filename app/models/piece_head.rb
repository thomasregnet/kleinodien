class PieceHead < ActiveRecord::Base
  validates :title, presence: true
end
