class CompilationRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [%w(date date), %w(date_mask mask)]

  belongs_to :head,
             class_name: CompilationHead,
             foreign_key: :compilation_head_id
  belongs_to :reference,  class_name: CrReference
  has_and_belongs_to_many :references,
                          class_name: CrReference,
                          join_table: :compilation_releases_references,
                          association_foreign_key: :reference_id

  has_many :companies, class_name: CrCompany
  has_many :credits, class_name: CrCredit
  has_many :formats,
           class_name: CrFormat,
           foreign_key: :compilation_release_id
  has_many :identifiers,
           class_name: CompilationIdentifier
  has_many :labels, class_name: CrLabel
  has_many :tracks
  has_and_belongs_to_many :countries

  validates :head, presence: true
  validates :type, presence: true
  validates_uniqueness_of :reference, allow_nil: true
  validates_uniqueness_of :version, scope: :head, case_sensitive: false

  delegate :title, to: :head

  def self.with_id_from_data_supplier_exists?(foreign_id, data_supplier)
    CrReference.joins(:compilation_release, :supplier).where(
      identifier: foreign_id,
      data_suppliers: { name: data_supplier }
    ).any?
  end
end
