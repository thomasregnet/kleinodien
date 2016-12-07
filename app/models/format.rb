class Format < ApplicationRecord
  self.primary_key = :abbr
  validates :abbr, presence: true
  validates :name, presence: true  
end
