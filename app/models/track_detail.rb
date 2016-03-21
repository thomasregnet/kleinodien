# Detail for a track format
class TrackDetail < ActiveRecord::Base
  belongs_to :kind,
             class_name: TrackDetailKind,
             foreign_key: :trf_attribute_kind_id
  belongs_to :track

  validates :kind,  presence: true
  validates :no,    presence: true
  validates :track,
            presence: true,
            uniqueness: { scope: :no }
end
