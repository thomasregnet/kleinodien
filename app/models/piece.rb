# A release of a song, movie ...
class Piece < ActiveRecord::Base
  include CodeFindable

  composed_of :date,
              class_name: 'IncompleteDate',
              mapping:    [%w[date date], %w[date_mask mask]]

  belongs_to :head,
             class_name:  'PieceHead',
             foreign_key: :piece_head_id,
             required:    false

  has_and_belongs_to_many :tags

  has_many :comments
  has_many :companies, class_name: 'PrCompany'
  has_many :credits, class_name: 'PrCredit'
  has_many :descriptions
  has_many :labels, class_name: 'PrLabel'
  has_many :ratings
  # TODO: must be PieceTrack when table piece_tracks exists
  has_many :tracks, class_name: 'CompilationTrack'

  has_and_belongs_to_many :countries

  delegate :title, to: :head
end
