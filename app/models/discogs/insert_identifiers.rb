class Discogs::InsertIdentifiers
  def self.perform(dc_identifiers, album_release)
    new(dc_identifiers, album_release).perform
  end

  def initialize(dc_identifiers, album_release)
    @dc_identifiers = dc_identifiers
    @album_release  = album_release
  end

  def perform
    return unless @dc_identifiers
    identifiers
  end

  private

  def identifiers
    @dc_identifiers.each do |dc_identifier|
      type = identifier_type(dc_identifier.type)
      @album_release.identifiers.create!(
        code: dc_identifier.value,
        type: type,
        disambiguation: dc_identifier.description
      )
    end
  end

  def identifier_type(name)
    IdentifierType.find_or_create_by!(name: name)
  end
end
