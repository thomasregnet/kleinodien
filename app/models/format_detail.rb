# More precise information for formats
class FormatDetail < ApplicationRecord
  validates :abbr, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
