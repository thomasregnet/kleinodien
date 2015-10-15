# ArtistCredit joins Artists with joinparses by using Participants
class ArtistCredit < ActiveRecord::Base
  has_many :artists, through: :participants
  has_many :participants, inverse_of: :artist_credit
  has_many :compilations, class_name: CompilationHead
  has_many :pieces, class_name: PieceHead
  validates(
    :name,
    presence: true,
    blank:    false,
    uniqueness: { case_sensitive: false }
  )
  validates :participants, presence: true

  before_save { self.name = name }

  def name
    names = participants.map do |participant|
      name = participant.artist.name
      name_with_joinparse(name, participant.joinparse)
    end
    names.join(' ')
  end

  def name_with_joinparse(name, joinparse)
    return name if joinparse.blank?
    "#{name} #{joinparse}"
  end
end
