class CompilationCopy < ApplicationRecord
  #belongs_to :compilation_release
  belongs_to :release,
             class_name:  CompilationRelease,
             foreign_key: :compilation_release_id
  belongs_to :user

  validates :release, presence: true
  validates :user, presence: true
end
