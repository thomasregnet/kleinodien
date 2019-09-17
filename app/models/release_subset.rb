class ReleaseSubset < ApplicationRecord
  belongs_to :release

  has_many :tracks, class_name: 'HeapTrack'

  validates :no, presence: true, blank: false
end
