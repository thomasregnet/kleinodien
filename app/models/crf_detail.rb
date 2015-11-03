class CrfDetail < ActiveRecord::Base
  belongs_to(
    :format,
    class_name: CrFormat,
    foreign_key: :cr_format_id
  )
  belongs_to(
    :kind,
    class_name: CrfAttributeKind,
    foreign_key: :crf_attribute_kind_id
  )
  validates :format, presence: true
  validates :kind,   presence: true
  validates :no,     presence: true
  validates_uniqueness_of :format, scope: :no
end
