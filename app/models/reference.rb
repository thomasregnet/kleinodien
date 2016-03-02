class Reference < ActiveRecord::Base
  belongs_to :supplier, class_name: DataSupplier, foreign_key: :data_supplier_id
  validates :supplier, presence: true
  validates :identifier, presence: true, blank: false
  validates :type, presence: true, blank: false

  def self.create_with_supplier_name!(klass, foreign_id, supplier_name)
    data_supplier = DataSupplier.find_or_create_by(name: supplier_name)
    klass.create!(identifier: foreign_id, supplier: data_supplier)
  end
end
