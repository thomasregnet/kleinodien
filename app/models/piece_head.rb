class PieceHead < ActiveRecord::Base
  validates :title, presence: true
  validates :type,  presence: true  
end
