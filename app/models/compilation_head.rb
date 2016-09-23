# The name giving group of one or many releases
class CompilationHead < ActiveRecord::Base
  belongs_to :source, foreign_key: :source_name
  has_many :companies, class_name: ChCompany
  has_many :credits, class_name: ChCredit
  has_many :labels, class_name: ChLabel
  has_and_belongs_to_many :countries

  validates :title, presence: true
  validates :type, presence: true
  validates :title,
            uniqueness: {
              scope:          [:type, :disambiguation, :source],
              case_sensitive: false
            }
end
