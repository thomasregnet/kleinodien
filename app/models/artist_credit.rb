# ArtistCredit joins Artists with join_phrases by using Participants
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
      #name_with_joinparse(name, participant.joinparse)
      name_with_join_phrase(name, participant.join_phrase)
    end
    names.join(' ')
  end

  #def name_with_joinparse(name, joinparse)
  def name_with_join_phrase(name, join_phrase)
    return name if join_phrase.blank?
    #"#{name} #{joinparse}"
    "#{name} #{join_phrase}"
  end
end
