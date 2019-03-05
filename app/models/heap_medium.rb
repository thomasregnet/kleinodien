class HeapMedium < ApplicationRecord
  belongs_to :heap
  belongs_to :format, class_name: 'MediumFormat'

  validates :position, presence: true
  validates :quantity, presence: true
end
