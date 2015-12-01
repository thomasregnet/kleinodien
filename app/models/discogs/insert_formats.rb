class Discogs::InsertFormats
  def self.perform(dc_formats, album_release)
    new(dc_formats, album_release).perform
  end

  def initialize(dc_formats, album_release)
    @dc_formats    = dc_formats
    @album_release = album_release
  end

  def perform
    @dc_formats.each_with_index.map do |dc_format, no|
      format(dc_format, no)
    end
  end

  private

  def format(dc_format, no)
    format = @album_release.formats.create!(
      kind:     CrFormatKind.find_or_create_by!(name: dc_format.name),
      note:     dc_format.text,
      quantity: dc_format.qty,
      no:       no
    )
    details(@dc_formats[no].descriptions, format)
  end

  def details(descriptions, format)
    descriptions.each_with_index do |description, no|
      attr_kind = CrfDetailKind.find_or_create_by!(name: description)
      format.details.create!(
        no:   no,
        kind: attr_kind
      )
    end
  end
end
