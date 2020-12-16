# frozen_string_literal: true

# Name giving group of AlbumReleases
class AlbumHead < ReleaseHead
  validates :artist_credit, presence: { message: "artist_credit can't be blank" }
end
