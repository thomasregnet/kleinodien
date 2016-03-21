# The artist releated to an ArtistCredit
class Artist < ActiveRecord::Base
  belongs_to :reference, class_name: ArtistReference
  has_many :participants, inverse_of: :artist
  has_and_belongs_to_many :references,
                          class_name: ArtistReference,
                          join_table: :artists_references,
                          association_foreign_key: :reference_id

  validates :name, presence: true
  validates :name,
            uniqueness: {
              scope:          [:disambiguation, :reference],
              case_sensitive: false
            }
  validates :reference, uniqueness: true, allow_nil: true

  def self.find_by_reference(identifier, data_supplier_name)
    data_supplier = DataSupplier.find_by(name: data_supplier_name)
    ref = ArtistReference.find_by(
      identifier: identifier,
      supplier:   data_supplier
    )
    return unless ref

    Artist.find_by(reference_id: ref.id)
  end
end
