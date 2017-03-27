class BrainzRelease < ApplicationRecord
  validates :mbid, presence: true
  validates :url,  presence: true, blank: false
  validates :data, presence: true, blank: false
end
