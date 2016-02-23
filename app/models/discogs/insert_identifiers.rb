module Discogs
  # Insets Identifiers like barcode, isbn ...
  class InsertIdentifiers
    def self.perform(dc_identifiers, album_release)
      new(dc_identifiers, album_release).perform
    end

    def initialize(dc_identifiers, album_release)
      @dc_identifiers = dc_identifiers
      @album_release  = album_release
    end

    def perform
      return unless @dc_identifiers

      @dc_identifiers.each do |dc_identifier|
        type = IdentifierType.find_or_create_by!(name: dc_identifier.type)
        @album_release.identifiers.create!(
          code:           dc_identifier.value,
          type:           type,
          disambiguation: dc_identifier.description
        )
      end
    end
  end
end
