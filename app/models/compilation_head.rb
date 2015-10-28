class CompilationHead < ActiveRecord::Base
  validates :title, presence: true
  validates :type, presence: true
  validates_uniqueness_of(
    :title,
    scope: [:type, :disambiguation],
    case_sensitive: false
  )
  validates_uniqueness_of :reference, allow_nil: true
  belongs_to :reference, class_name: ChReference
  has_many :companies, class_name: ChCompany
  has_many :credits, class_name: ChCredit
  has_many :labels, class_name: ChLabel
  has_and_belongs_to_many :countries
  has_and_belongs_to_many(
    :references,
    class_name: ChReference,
    join_table: :compilation_heads_references,
    association_foreign_key: :reference_id
  )
end
