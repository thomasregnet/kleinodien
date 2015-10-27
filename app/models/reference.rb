class Reference < ActiveRecord::Base
  belongs_to :supplier, class_name: DataSupplier, foreign_key: :data_supplier_id
  validates :supplier, presence: true
  validates :identifier, presence: true, blank: false
  validates :type, presence: true, blank: false
end
