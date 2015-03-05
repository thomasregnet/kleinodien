class CompilationMedium < ActiveRecord::Base
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  has_many(
    :sections,
    class_name: CompilationSection,
    foreign_key: :compilation_medium_id)
  validates :release, presence: true
  validates :no, presence: true
  validates_uniqueness_of :release, scope: :no
end
