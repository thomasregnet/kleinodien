# CompilationRelease Format Detail
class CrfDetail < ActiveRecord::Base
  belongs_to :format,
             class_name: CrFormat,
             foreign_key: :cr_format_id
  belongs_to :kind,
             class_name: CrfDetailKind,
             foreign_key: :crf_detail_kind_id

  validates :format,   presence: true, uniqueness: { scope: :position }
  validates :kind,     presence: true
  validates :position, presence: true
end
