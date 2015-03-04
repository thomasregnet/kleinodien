class CompilationSection < ActiveRecord::Base
  belongs_to(
    :format,
    class_name: SectionFormat,
    foreign_key: :section_format_id)
  belongs_to(
    :medium, class_name: CompilationMedium,
    foreign_key: :compilation_medium_id)
end
