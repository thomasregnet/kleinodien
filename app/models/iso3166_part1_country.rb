class Iso3166Part1Country < ApplicationRecord
  belongs_to :area

  validates :code, presence: true, blank: false
end
