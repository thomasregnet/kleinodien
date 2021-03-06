# frozen_string_literal: true

# A release of a song, movie ...
class Piece < ActiveRecord::Base
  include CodeFindable

  composed_of :date,
              class_name: 'IncompleteDate',
              mapping:    [%w[date date], %w[date_mask mask]]

  composed_of :duration,
              class_name: 'Duration',
              mapping:    [%w[milliseconds milliseconds], %w[accuracy accuracy]]

  belongs_to :head,
             class_name:  'PieceHead',
             foreign_key: :piece_head_id,
             required:    false
  belongs_to :import_order, required: false

  has_and_belongs_to_many :tags
  has_many :companies, class_name: 'PrCompany'
  has_many :release_tracks
  has_many :labels, class_name: 'PrLabel'
  has_many :ratings
  has_many :piece_tracks
end
