class Discogs::InsertFormats
  def self.perform(dc_formats, album_release)
    new(dc_formats).perform
  end

  def initialize(dc_formats, album_release)
    @dc_formats    = dc_formats
    @album_release = album_release
  end

  def perform
  end
end
