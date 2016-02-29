class PieceHead < ActiveRecord::Base
  belongs_to :reference, class_name: PhReference
  has_many :companies, class_name: PhCompany
  has_many :credits, class_name: PhCredit
  has_many :labels, class_name: PhLabel
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :references,
                          class_name: PhReference,
                          join_table: :piece_heads_references,
                          association_foreign_key: :reference_id

  validates :title, presence: true
  validates :type,  presence: true
  validates_uniqueness_of :reference, allow_nil: true
  validates_uniqueness_of :title,
                          scope: [:type, :disambiguation, :reference],
                          case_sensitive: false

  def self.with_id_from_data_supplier(foreign_id, data_supplier)
    PhReference.joins(:piece_head, :supplier).where(
      identifier:     foreign_id,
      data_suppliers: { name: data_supplier }
    ).first
  end
end
