# A release of a song, movie ...
class PieceRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [%w(date date), %w(date_mask mask)]

  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
  belongs_to :source, primary_key: :name, foreign_key: :source_name

  has_many :companies, class_name: PrCompany
  has_many :credits, class_name: PrCredit
  has_many :labels, class_name: PrLabel
  # TODO: must be PieceTrack when table piece_tracks exists
  has_many :tracks, class_name: CompilationTrack

  has_and_belongs_to_many :countries

  delegate :title, to: :head

  validates :source_ident,
            uniqueness: { allow_blank: true, scope: [:source_name, :type] }
end
