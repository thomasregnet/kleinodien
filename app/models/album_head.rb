# frozen_string_literal: true

# Name giving group of AlbumReleases
class AlbumHead < ReleaseHead
  validates :artist_credit, presence: true
end
