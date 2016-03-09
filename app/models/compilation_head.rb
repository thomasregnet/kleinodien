class CompilationHead < ActiveRecord::Base
  belongs_to :reference, class_name: ChReference
  has_many :companies, class_name: ChCompany
  has_many :credits, class_name: ChCredit
  has_many :labels, class_name: ChLabel
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :references,
                          class_name: ChReference,
                          join_table: :compilation_heads_references,
                          association_foreign_key: :reference_id

  validates :title, presence: true
  validates :type, presence: true
  validates_uniqueness_of :title,
                          scope: [:type, :disambiguation, :reference],
                          case_sensitive: false
  validates_uniqueness_of :reference, allow_nil: true

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

  def self.find_by_reference(foreign_id, data_supplier_name)
    ref = ChReference.joins(:compilation_head, :supplier).where(
      identifier:     foreign_id,
      data_suppliers: { name: data_supplier_name }
    ).first

    return unless ref

    CompilationHead.find_by(reference_id: ref.id)
  end
end
