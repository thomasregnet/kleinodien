class PieceRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [%w(date date), %w(date_mask mask)]

  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
  belongs_to :reference, class_name: PrReference
  has_many :companies, class_name: PrCompany
  has_many :credits, class_name: PrCredit
  has_many :labels, class_name: PrLabel
  has_many :tracks
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :references,
                          class_name: PrReference,
                          join_table: :piece_releases_references,
                          association_foreign_key: :reference_id

  validates_uniqueness_of :reference, allow_nil: true
  delegate :title, to: :head

  def self.find_by_reference(identifier, data_supplier_name)
    data_supplier = DataSupplier.find_by(name: data_supplier_name)
    ref = PrReference.find_by(
      identifier: identifier,
      supplier:   data_supplier
    )

    return unless ref
    #byebug
    PieceRelease.find_by(reference_id: ref.id)
  end
end
