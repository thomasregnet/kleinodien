class ArtistCredit < ActiveRecord::Base
  has_many :artists, through: :participants
  has_many :participants, inverse_of: :artist_credit
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :participants, presence: true

  before_save { self.name = name }
  
  def name
    names = []
    participants.each do |p|
      names << p.artist.name
      names << p.joinparse unless p.joinparse.blank?
    end
    names.join(' ')
  end
end
