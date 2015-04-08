class TrfAttribute < ActiveRecord::Base
  belongs_to :track
  belongs_to(
    :kind,
    class_name: TrfAttributeKind,
    foreign_key: :trf_attribute_kind_id
  )
  validates :track, presence: true
  validates :kind, presence: true
  validates :no, presence: true
end
