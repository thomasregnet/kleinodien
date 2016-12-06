class Format < ApplicationRecord
  validates :abbr, presence: true
  validates :name, presence: true  
end
