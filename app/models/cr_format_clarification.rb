class CrFormatClarification < ActiveRecord::Base
  validates :no, presence: true
  validates :format, presence: true
  validates :kind, presence: true
  validates_uniqueness_of :format, scope: :no
  belongs_to :format, class_name: CrFormat, foreign_key: :cr_format_id
  belongs_to :kind, class_name: Format, foreign_key: :format_kind_id
end
