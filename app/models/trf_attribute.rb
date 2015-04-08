class TrfAttribute < ActiveRecord::Base
  belongs_to :track
  belongs_to(
    :kind,
    class_name: TrfAttributeKind,
    foreign_key: :trf_attribute_kind_id
  )
end
