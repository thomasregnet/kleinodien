class CrFormat < ActiveRecord::Base
  validates :release,     presence: true
  validates :format_kind, presence: true
  validates :quantity,    presence: true
  validates :no,          presence: true  
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  belongs_to(
    :format_kind,
    class_name: FormatKind,
    foreign_key: :format_kind_id)
end
