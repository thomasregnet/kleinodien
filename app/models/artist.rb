# The artist releated to an ArtistCredit
class Artist < ActiveRecord::Base
  include BrainzConstructors
  include Identifyable

  has_many :identifiers, class_name: 'ArtistIdentifier'
  # belongs_to :source

  composed_of :begin_date,
              class_name: 'IncompleteDate',
              mapping: [%w(begin_date date), %w(begin_date_mask mask)]
  composed_of :end_date,
              class_name: 'IncompleteDate',
              mapping: [%w(end_date date), %w(end_date_mask mask)]

  has_and_belongs_to_many :tags
  has_many :comments
  has_many :descriptions
  has_many :participants, inverse_of: :artist
  has_many :ratings

  validates :name, presence: true
  validates :name, uniqueness: { scope: :disambiguation, case_sensitive: false }

  delegate :name, to: :source, prefix: :source

  def self.brainz_parameters(brainz_artist)
    Hash[
      name:           brainz_artist.name,
      sort_name:      brainz_artist.sort_name,
      disambiguation: brainz_artist.disambiguation
    ]
  end
end
