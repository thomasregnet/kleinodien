class PieceRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [ %w(date date), %w(date_mask mask) ]
  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
  belongs_to :reference, class_name: PrReference
  has_many :credits, class_name: PrCredit
  has_many :companies, class_name: PrCompany
  has_many :labels, class_name: PrLabel
  has_many :tracks
  has_and_belongs_to_many :countries
  validates_uniqueness_of :reference, allow_nil: true
  delegate :title, to: :head
end
