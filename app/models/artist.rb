# The artist releated to an ArtistCredit
class Artist < ActiveRecord::Base
  belongs_to :identifier,
             class_name: ArtistIdentifier,
             foreign_key: :artist_identifier_id
  belongs_to :source

  composed_of :begin_date,
              class_name: 'IncompleteDate',
              mapping: [%w(begin_date date), %w(begin_date_mask mask)]
  composed_of :end_date,
              class_name: 'IncompleteDate',
              mapping: [%w(end_date date), %w(end_date_mask mask)]
  
  # note that the class_name has to be quoted
  has_and_belongs_to_many :alt_identifiers,
                          class_name: 'ArtistIdentifier'
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :descriptions
  has_many :participants, inverse_of: :artist
  has_many :ratings

  validates :name, presence: true
  validates :name,
            uniqueness: {
              scope:          [:disambiguation, :identifier],
              case_sensitive: false
            }

  delegate :name, to: :source, prefix: :source
end
