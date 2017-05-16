# Label of a CompilationRelease
class CrLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :compilation_release
end
