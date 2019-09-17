class ReleaseMedium < ApplicationRecord
  # belongs_to :heap
  belongs_to :format, class_name: 'MediumFormat', foreign_key: :medium_format_id
  belongs_to :release

  validates :position, presence: true
  validates :quantity, presence: true
end
