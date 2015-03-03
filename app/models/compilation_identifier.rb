class CompilationIdentifier < ActiveRecord::Base
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)  
  belongs_to(
    :type,
    class_name: IdentifierType,
    foreign_key: :identifier_type_id)
end
