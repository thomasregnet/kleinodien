# What an Artist distributed to a CompilationRelease
class CrCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :compilation_release
  belongs_to :job

  validates :artist_credit, presence: true
  validates :compilation_release, presence: true
end
