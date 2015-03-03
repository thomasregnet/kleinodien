class CompilationIdentifier < ActiveRecord::Base
  belongs_to :compilation_release
  belongs_to :identifier_type
end
