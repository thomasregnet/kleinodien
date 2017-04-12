# The name giving group of one or many releases
class CompilationHead < ActiveRecord::Base
  include BrainzConstructors

  has_many :identifiers, class_name: ChIdentifier
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :descriptions
  has_many :companies, class_name: ChCompany
  has_many :credits, class_name: ChCredit
  has_many :labels, class_name: ChLabel
  has_many :ratings
  has_and_belongs_to_many :countries

  validates :type, presence: true
  validates :title,
            presence: true,
            uniqueness: {
              scope:          %i(type disambiguation),
              case_sensitive: false
            }

  def self.brainz_parameters(args)
    brainz = args[:brainz]
    Hash[
      artist_credit:  args[:artist_credit],
      title:          brainz.title,
      disambiguation: brainz.disambiguation
    ]
  end
end
