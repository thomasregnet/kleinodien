class PieceRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [ %w(date date), %w(date_mask mask) ]
  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
  has_many :credits, class_name: PrCredit
  has_many :labels, class_name: PrLabel
  has_many :tracks
  has_and_belongs_to_many :countries
  delegate :title, to: :head
end
