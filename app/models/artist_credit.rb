# ArtistCredit joins Artists with join_phrases by using Participants
class ArtistCredit < ActiveRecord::Base
  has_many :artists, through: :participants
  has_many :participants, inverse_of: :artist_credit
  has_many :compilations, class_name: CompilationHead
  has_many :pieces, class_name: PieceHead

  validates :name,
            presence: true,
            blank:    false,
            uniqueness: { case_sensitive: false }

  validates :participants, presence: true

  before_save { self.name = name }

  def name
    return unless participants
    return if participants.empty?
    KleinodienUtil::JoinNames.perform(
      participants
    )
  end
end
