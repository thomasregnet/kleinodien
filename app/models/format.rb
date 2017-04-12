# Formats may be for files or Media
class Format < ApplicationRecord
  validates :abbr, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
