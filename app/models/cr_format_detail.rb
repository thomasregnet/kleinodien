# CopilationRelease format detail
class CrFormatDetail < ApplicationRecord
  belongs_to :detail,
             class_name: 'FormatDetail',
             foreign_key: :format_detail_id
  belongs_to :format,
             class_name: 'CrFormat',
             foreign_key: :cr_format_id

  validates :position, presence: true

  delegate :name, to: :format
end
