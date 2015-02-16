class Season < ActiveRecord::Base
  belongs_to :serial
  validates :serial, presence: true
  validates :no,     presence: true
end
