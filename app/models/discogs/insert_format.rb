module Discogs
  # Insert a format for a medium
  class InsertFormat
    def self.perform(dc_format, album_release, position)
      new(dc_format, album_release, position).perform
    end

    def initialize(dc_format, album_release, position)
      @dc_format     = dc_format
      @album_release = album_release
      @position      = position
    end

    def perform
      format
      details
    end

    private

    def details
      @dc_format.descriptions.each_with_index do |description, position|
        detail = FormatDetail.find_or_create_by!(name: description)
        @format.details.create!(
          position: position,
          detail:   detail
        )
      end
    end

    def format
      @format = @album_release.formats.create!(
        format:   Format.find_or_create_by!(name: @dc_format.name),
        note:     @dc_format.text,
        quantity: @dc_format.qty,
        position: @position
      )
    end
  end
end
