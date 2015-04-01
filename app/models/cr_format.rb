class CrFormat < ActiveRecord::Base
  validates :release,  presence: true
  validates :format,   presence: true
  validates :quantity, presence: true
  validates :no,       presence: true
  validates_uniqueness_of :no, scope: :release
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  belongs_to(
    #:format_kind,
    :format,
    #class_name: FormatKind,
    foreign_key: :format_kind_id)
  has_many(:clarifications, class_name: CrFormatClarification)
end
