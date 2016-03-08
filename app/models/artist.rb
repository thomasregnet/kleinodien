class Artist < ActiveRecord::Base
  belongs_to :reference, class_name: ArtistReference
  has_many :participants, inverse_of: :artist
  has_and_belongs_to_many :references,
                          class_name: ArtistReference,
                          join_table: :artists_references,
                          association_foreign_key: :reference_id

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :disambiguation, case_sensitive: false
  validates_uniqueness_of :reference, allow_nil: true

  def self.find_by_reference(identifier, data_supplier_name)
    ref = ArtistReference.joins(:artist, :supplier).where(
      identifier: identifier,
      data_suppliers: { name: data_supplier_name }
    ).first || return
    Artist.find_by(reference_id: ref.id)
  end
end
