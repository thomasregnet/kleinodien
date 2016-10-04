class CompilationCopy < ApplicationRecord
  belongs_to :compilation_release
  belongs_to :user
end
