class CrFormatClarification < ActiveRecord::Base
  validates :no, presence: true
  validates :format, presence: true
  validates :format_kind, presence: true
  validates_uniqueness_of :format, scope: :no
  belongs_to :format, class_name: CrFormat, foreign_key: :cr_format_id
  belongs_to :format_kind
end
