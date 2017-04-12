# Identifies a release, for example a barcode
class ProductNumber < ActiveRecord::Base
  belongs_to :release,
             class_name: CompilationRelease,
             foreign_key: :compilation_release_id
  belongs_to :type,
             class_name: ProductNumberType,
             foreign_key: :product_number_type_id

  validates :code,
            presence: true,
            blank: false,
            uniqueness: { scope: %i(release type disambiguation) }

  validates :release, presence: true
  validates :type, presence: true
end
