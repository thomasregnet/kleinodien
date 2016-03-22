# Reference to the data-source of a CompilationHead
class ChReference < Reference
  has_one :compilation_head, foreign_key: 'reference_id'

  def self.create_with_supplier_name!(foreign_id, supplier_name)
    Reference.create_with_supplier_name!(self, foreign_id, supplier_name)
  end
end
