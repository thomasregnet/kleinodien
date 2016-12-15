# ArtistCredit joins Artists with join_phrases by using Participants
class ArtistCredit < ActiveRecord::Base
  #belongs_to :data_supplier
  belongs_to :source, primary_key: :name, foreign_key: :source_name

  has_many :artists, through: :participants
  has_many :participants, inverse_of: :artist_credit
  has_many :compilations, class_name: CompilationHead
  has_many :pieces, class_name: PieceHead

  validates :name,
            presence: true,
            blank:    false,
            uniqueness: { case_sensitive: false, scope: :source }
            #uniqueness: { case_sensitive: false, scope: :data_supplier_id }

  validates :participants, presence: true

  #before_save { self.name = name }
  before_save { write_attribute(:name, name) }
  before_validation { self.name = name }

  def name
    return unless participants
    return if participants.empty?
    KleinodienUtil::JoinNames.perform(
      participants
    )
  end
end
