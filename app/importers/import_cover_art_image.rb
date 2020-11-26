# frozen_string_literal: true

# Import an image from coverartarchive.org
class ImportCoverArtImage < ImportCoverArtBase
  def initialize(metadata:, target_object:, **args)
    super(args)
    @metadata      = metadata
    @target_object = target_object
  end

  attr_reader :metadata, :target_object

  def find_existing
    Image.find_by(coverartarchive_code: metadata[:id])
  end

  # rubocop:disable Metrics/AbcSize
  def persist
    target_object.back_cover   = metadata[:back]
    target_object.front_cover  = metadata[:front]
    target_object.image        = image
    target_object.import_order = import_order
    target_object.note         = metadata[:comment]

    target_object.save!

    tags.each { |tag| target_object.tags.find_or_create_by(name: tag) }

    target_object
  end
  # rubocop:enable Metrics/AbcSize

  def prepare
    image_io
  end

  private

  def create_image
    image = Image.create!(coverartarchive_code: metadata[:id], import_order: import_order)
    image.file.attach(io: image_io, filename: "coverartarchiveorg_#{metadata[:id]}")

    image
  end

  def fetch_image
    import_request = CoverArtImageImportRequest.create!(import_order: import_order, uri: metadata[:image])
    CoverArtFetcher.call(import_request: import_request).body
  end

  def image
    @image ||= create_image
  end

  def image_io
    @image_io ||= StringIO.new(fetch_image)
  end

  def import_request
    CoverArtImageImportRequest.create!(import_order: import_order, uri: uri)
  end

  # note that kleinodien uses the coverartarchive.org "types" as "tags"
  def tags
    metadata[:types] || []
  end
end
