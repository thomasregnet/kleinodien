module Discogs
  # Insert a format for a medium
  class InsertFormat
    def self.perform(dc_format, album_release, no)
      new(dc_format, album_release, no).perform
    end

    def initialize(dc_format, album_release, no)
      @dc_format     = dc_format
      @album_release = album_release
      @no            = no
    end

    def perform
      format
      details
    end

    private

    def details
      @dc_format.descriptions.each_with_index do |description, no|
        attr_kind = CrfDetailKind.find_or_create_by!(name: description)
        @format.details.create!(
          no:   no,
          kind: attr_kind
        )
      end
    end

    def format
      @format = @album_release.formats.create!(
        kind:     CrFormatKind.find_or_create_by!(name: @dc_format.name),
        note:     @dc_format.text,
        quantity: @dc_format.qty,
        no:       @no
      )
    end
  end
end
