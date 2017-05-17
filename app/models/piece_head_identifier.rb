# Parent class for other Identifiers eg. SongHeadIdentifier
class PieceHeadIdentifier < ApplicationRecord
  belongs_to :piece_head
  belongs_to :source

  validates :value, presence: true, blank: false

  alias_attribute :identified, :piece_head
end
