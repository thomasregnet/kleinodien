# The name giving group of one or many releases
class CompilationHead < ActiveRecord::Base
  #belongs_to :source, foreign_key: :source_name
  belongs_to :source
  has_many :companies, class_name: ChCompany
  has_many :credits, class_name: ChCredit
  has_many :labels, class_name: ChLabel
  has_and_belongs_to_many :countries

  validates :type, presence: true
  validates :source_ident,
            uniqueness: { allow_blank: true, scope: [:source_id, :type] }
  validates :title,
            presence: true,
            uniqueness: {
              scope:          [:type, :disambiguation, :source],
              case_sensitive: false
            }
end
