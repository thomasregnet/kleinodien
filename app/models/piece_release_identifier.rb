class PieceReleaseIdentifier < ApplicationRecord
  belongs_to :piece_release
  belongs_to :source

  validates :piece_release, presence: true
  validates :source, presence: true
  validates :value, presence: true, blank: false

  alias_attribute :identified, :piece_release
end
