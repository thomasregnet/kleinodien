class PieceHeadIdentifier < ApplicationRecord
  belongs_to :piece_head
  belongs_to :source

  validates :piece_head, presence: true
  validates :source, presence: true
  validates :value, presence: true, blank: false

  alias_attribute :identified, :piece_head
end
