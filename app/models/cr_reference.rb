class CrReference < Reference
  has_one :compilation_release, foreign_key: 'reference_id'

  def self.create_with_supplier_name!(foreign_id, supplier_name)
    data_supplier = DataSupplier.find_or_create_by(name: supplier_name)
    create!(identifier: foreign_id, supplier: data_supplier)
  end
end
