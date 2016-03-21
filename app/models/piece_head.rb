# A PieceHead my be a song, movie ...
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
  validates :reference, uniqueness: true, allow_nil: true
  validates :title,
            uniqueness: {
              scope: [:type, :disambiguation,
                      :artist_credit_id, :reference],
              case_sensitive: false
            }
  def self.with_id_from_data_supplier(foreign_id, data_supplier)
    PhReference.joins(:piece_head, :supplier).where(
      identifier:     foreign_id,
      data_suppliers: { name: data_supplier }
    ).first
  end

  def self.find_by_reference(identifier, data_supplier_name)
    data_supplier = DataSupplier.find_by(name: data_supplier_name)
    ref = PhReference.find_by(
      identifier: identifier,
      supplier:   data_supplier
    )

    return unless ref

    PieceHead.find_by(reference_id: ref.id)
  end
end
