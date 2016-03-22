# Label of a CompilationRelease
class CrLabel < ActiveRecord::Base
  belongs_to :compilation_release
  belongs_to :company

  validates :company, presence: true
  validates :compilation_release, presence: true
end
