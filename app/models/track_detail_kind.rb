# For example "variable bit rate"
class TrackDetailKind < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
