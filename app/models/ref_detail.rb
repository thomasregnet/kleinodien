# Repository format detail
class RefDetail < ApplicationRecord
  self.primary_key = :name
  belongs_to :format, primary_key: :name, foreign_key: :name
  validates :name, presence: true
  delegate :abbr, to: :format
end
