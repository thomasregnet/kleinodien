# frozen_string_literal: true

# A Video, derived from Piece
class Video < Piece
  belongs_to :artist_credit, required: false
end
