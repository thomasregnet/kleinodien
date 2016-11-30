# CompilationRelease Format Detail
class CrfDetail < ActiveRecord::Base
  belongs_to :format,
             class_name: CrFormat,
             foreign_key: :cr_format_id
  belongs_to :kind,
             class_name: CrfDetailKind,
             foreign_key: :crf_detail_kind_id

  validates :format, presence: true, uniqueness: { scope: :no }
  validates :kind,   presence: true
  validates :no,     presence: true
end
