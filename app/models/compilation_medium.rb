class CompilationMedium < ActiveRecord::Base
  belongs_to(
    :release,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  validates :release, presence: true
  validates :no, presence: true
  validates_uniqueness_of :release, scope: :no
end
