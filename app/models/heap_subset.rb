class HeapSubset < ApplicationRecord
  belongs_to :heap

  has_many :tracks, class_name: 'HeapTrack'

  validates :no, presence: true, blank: false
end
