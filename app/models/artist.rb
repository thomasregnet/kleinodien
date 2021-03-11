# frozen_string_literal: true

# The artist related to an ArtistCredit
class Artist < ActiveRecord::Base
  include CodeFindable

  belongs_to :import_order, required: false

  # composed_of :begin_date,
  #             class_name: 'IncompleteDate',
  #             mapping:    [%w[begin_date date], %w[begin_date_mask mask]],
  #             allow_nil:  true
  # composed_of :end_date,
  #             class_name: 'IncompleteDate',
  #             mapping:    [%w[end_date date], %w[end_date_mask mask]],
  #             allow_nil:  true

  has_and_belongs_to_many :tags
  has_many :participants, inverse_of: :artist
  has_many :ratings

  validates :brainz_code, uniqueness: { allow_blank: true }
  validates :discogs_code, uniqueness: { allow_blank: true }
  validates :wikidata_code, uniqueness: { allow_blank: true }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :disambiguation, case_sensitive: false }

  delegate :name, to: :source, prefix: :source
end
