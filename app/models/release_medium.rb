# frozen_string_literal: true

# A Release may be stored on one or more media
class ReleaseMedium < ApplicationRecord
  belongs_to :format, class_name: 'MediumFormat', foreign_key: :medium_format_id
  belongs_to :release

  validates :position, presence: true
  validates :quantity, presence: true
end
