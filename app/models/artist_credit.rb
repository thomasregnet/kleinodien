# ArtistCredit joins Artists with joinparses by using Participants
class ArtistCredit < ActiveRecord::Base
  has_many :artists, through: :participants
  has_many :participants, inverse_of: :artist_credit
  has_many :compilations, class_name: CompilationHead
  has_many :pieces, class_name: PieceHead
  validates :name, presence: true, blank: false, uniqueness: { case_sensitive: false }
  validates :participants, presence: true

  before_save { self.name = name }
  
  def name
    names = []
    participants.each do |participant|
      names << participant.artist.name
      joinparse = participant.joinparse
      names << joinparse unless joinparse.blank?
    end
    names.join(' ')
  end
end
