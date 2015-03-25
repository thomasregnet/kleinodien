class CrFormat < ActiveRecord::Base
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  belongs_to(
    :format_kind,
    class_name: FormatKind,
    foreign_key: :format_kind_id)
end
