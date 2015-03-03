class CompilationRelease < ActiveRecord::Base
  belongs_to(:head,
             class_name: CompilationHead,
             foreign_key: :compilation_head_id)
end
