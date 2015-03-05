class CompilationRelease < ActiveRecord::Base
  validates :head, presence: true
  validates :type, presence: true
  belongs_to(
    :head,
    class_name: CompilationHead,
    foreign_key: :compilation_head_id)
  has_many(
    :identifiers,
    class_name: CompilationIdentifier)
  has_many(
    :media,
    class_name: CompilationMedium,
    foreign_key: :compilation_release_id)
  validates_uniqueness_of :version, scope: :head, case_sensitive: false
end
