# Name giving group of AlbumReleases
class AlbumHead < CompilationHead
  belongs_to :artist_credit
  has_many :releases,
           class_name:  'AlbumRelease',
           foreign_key: :compilation_head_id

  validates :artist_credit, presence: true
end
