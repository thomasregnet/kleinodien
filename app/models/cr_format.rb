class CrFormat < ActiveRecord::Base
  validates :release,  presence: true
  validates :kind,     presence: true
  validates :quantity, presence: true
  validates :no,       presence: true
  validates_uniqueness_of :no, scope: :release
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  #belongs_to :format
  belongs_to :kind, class_name: CrFormatKind, foreign_key: :cr_format_kind_id
  
  has_many(:clarifications, class_name: CrFormatClarification)
end
