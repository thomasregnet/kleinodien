class HeapMedium < ApplicationRecord
  belongs_to :heap
  belongs_to :format, class_name: 'MediumFormat', foreign_key: :medium_format_id

  validates :position, presence: true
  validates :quantity, presence: true
end
