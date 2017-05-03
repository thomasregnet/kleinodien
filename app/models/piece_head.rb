# A PieceHead my be a song, movie ...
class PieceHead < ActiveRecord::Base
  belongs_to :source
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :companies, class_name: 'PhCompany'
  has_many :descriptions
  has_many :credits, class_name: 'PhCredit'
  has_many :labels, class_name: 'PhLabel'
  has_many :ratings

  validates :title,
            presence: true,
            uniqueness: {
              scope: %i(type disambiguation artist_credit_id source_id),
              case_sensitive: false
            }
  validates :type, presence: true
  validates :source_ident,
            uniqueness: { allow_blank: true, scope: %i(source_id type) }

  delegate :name, to: :source, prefix: :source
end
