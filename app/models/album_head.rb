# frozen_string_literal: true

# Name giving group of AlbumReleases
class AlbumHead < HeapHead
  belongs_to :artist_credit
  has_many :releases,
           class_name:  'AlbumRelease',
           foreign_key: :compilation_head_id
end
