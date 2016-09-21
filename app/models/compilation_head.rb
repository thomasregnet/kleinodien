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

  def self.with_id_from_data_supplier_exists?(foreign_id, data_supplier)
    ChReference.joins(:compilation_head, :supplier).where(
      identifier:     foreign_id,
      data_suppliers: { name: data_supplier }
    ).any?
  end

  def self.with_id_from_data_supplier(foreign_id, data_supplier)
    ChReference.joins(:compilation_head, :supplier).where(
      identifier:     foreign_id,
      data_suppliers: { name: data_supplier }
    ).first
  end
end
