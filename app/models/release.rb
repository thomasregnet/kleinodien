# frozen_string_literal: true

# A Release of Pieces
class Release < ApplicationRecord
  belongs_to :area, required: false
  belongs_to :artist_credit, required: false
  belongs_to :head, class_name: 'ReleaseHead', foreign_key: :release_head_id
  belongs_to :import_order, required: false
  belongs_to :language, required: false
  belongs_to :script, required: false

  has_many :media, class_name: 'ReleaseMedium'
  has_many :release_companies
  has_many :release_events
  has_many :subsets, class_name: 'ReleaseSubset'
end
