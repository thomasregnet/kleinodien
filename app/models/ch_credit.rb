# ArtistCredit of a CompilationHead
class ChCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :compilation_head
  belongs_to :job

  validates :artist_credit,    presence: true
  validates :compilation_head, presence: true
end
