# A PieceHead my be a song, movie ...
class PieceHead < ActiveRecord::Base
  belongs_to :source
  has_many :comments
  has_many :companies, class_name: PhCompany
  has_many :credits, class_name: PhCredit
  has_many :labels, class_name: PhLabel
  has_many :ratings

  has_and_belongs_to_many :countries

  validates :title,
            presence: true,
            uniqueness: {
              scope: [:type, :disambiguation, :artist_credit_id, :source_id],
              case_sensitive: false
            }
  validates :type, presence: true
  validates :source_ident,
              uniqueness: { allow_blank: true, scope: [:source_id, :type] }

  delegate :name, to: :source, prefix: :source
end
