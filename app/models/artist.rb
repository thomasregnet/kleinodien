class Artist < ActiveRecord::Base
  belongs_to :reference, class_name: ArtistReference
  has_many :participants, inverse_of: :artist

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :disambiguation, case_sensitive: false
  validates_uniqueness_of :reference, allow_nil: true
end
