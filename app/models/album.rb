# frozen_string_literal: true

# Release of a music album
class Album < Release
  belongs_to :artist_credit, required: false
end
