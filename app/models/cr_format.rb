# CompilationRelease Format
class CrFormat < ActiveRecord::Base
  # belongs_to :kind,
  #            class_name: CrFormatKind,
  #            foreign_key: :cr_format_kind_id
  belongs_to :format,
             foreign_key: :abbr,
             primary_key: :abbr
  belongs_to :release,
             class_name: CompilationRelease,
             foreign_key: :compilation_release_id
  has_many :details,
           class_name: CrfDetail

  validates :format,   presence: true
  validates :position, presence: true, uniqueness: { scope: :release }
  validates :quantity, presence: true
  validates :release,  presence: true
end
