class Season < ActiveRecord::Base
  belongs_to :serial, inverse_of: :seasons
  validates :serial, presence: true
  validates :no,     presence: true
end
