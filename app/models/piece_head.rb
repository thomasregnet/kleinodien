# A PieceHead my be a song, movie ...
class PieceHead < ActiveRecord::Base
  belongs_to :source, primary_key: :source_name
  has_many :companies, class_name: PhCompany
  has_many :credits, class_name: PhCredit
  has_many :labels, class_name: PhLabel
  has_and_belongs_to_many :countries

  validates :title, presence: true
  validates :type,  presence: true
  validates :title,
            uniqueness: {
              scope: [:type, :disambiguation,
                      :artist_credit_id, :source_name], #:reference],
              case_sensitive: false
            }
end
