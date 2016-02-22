class CrFormat < ActiveRecord::Base
  belongs_to :kind,
             class_name: CrFormatKind,
             foreign_key: :cr_format_kind_id
  belongs_to :release,
             class_name: CompilationRelease,
             foreign_key: :compilation_release_id
  has_many :details,
           class_name: CrfDetail

  validates :kind,     presence: true
  validates :no,       presence: true
  validates :quantity, presence: true
  validates :release,  presence: true
  validates_uniqueness_of :no, scope: :release
end
