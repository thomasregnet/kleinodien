class CompilationIdentifier < ActiveRecord::Base
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)  
  belongs_to(
    :type,
    class_name: IdentifierType,
    foreign_key: :identifier_type_id)
  validates :release, presence: true
  validates :type, presence: true
  validates :code, presence: true, blank: false
  validates_uniqueness_of(
    :code,
    scope: [:release, :type, :disambiguation],
    case_sensitive: false)
end
