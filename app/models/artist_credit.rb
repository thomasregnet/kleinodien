# ArtistCredit joins Artists with join_phrases by using Participants
class ArtistCredit < ActiveRecord::Base
  belongs_to :source, required: false

  has_and_belongs_to_many :tags

  has_many :artists, through: :participants
  has_many :comments
  has_many :descriptions
  has_many :participants, inverse_of: :artist_credit
  has_many :compilations, class_name: 'CompilationHead'
  has_many :compilation_releases
  has_many :pieces, class_name: 'PieceHead'
  has_many :ratings

  validates :name,
            presence: true,
            blank:    false,
            uniqueness: { case_sensitive: false, scope: :source }

  before_save { self.name = forced_name }
  before_validation { self.name = forced_name }

  def forced_name
    return name if name
    combined_name
  end

  def combined_name
    return unless participants
    return if participants.empty?
    KleinodienUtil::JoinNames.perform(
      participants
    )
  end
end
