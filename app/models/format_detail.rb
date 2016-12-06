class FormatDetail < ApplicationRecord
  validates :abbr, presence: true
  validates :name, presence: true
end
