# Supplier of metadata like MusicBrainz, Discogs ...
class DataSupplier < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
