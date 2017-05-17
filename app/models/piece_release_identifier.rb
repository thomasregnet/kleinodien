# Parent class for other Identifiers eg. SongReleaseIdentifier
class PieceReleaseIdentifier < ApplicationRecord
  belongs_to :piece_release
  belongs_to :source

  validates :value, presence: true, blank: false

  alias_attribute :identified, :piece_release
end
