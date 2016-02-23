module Discogs
  # Inserts AlbumRelease Formats
  class InsertFormats
    def self.perform(dc_formats, album_release)
      new(dc_formats, album_release).perform
    end

    def initialize(dc_formats, album_release)
      @dc_formats    = dc_formats
      @album_release = album_release
    end

    def perform
      @dc_formats.each_with_index.map do |dc_format, no|
        Discogs::InsertFormat.perform(dc_format, @album_release, no)
      end
    end
  end
end
