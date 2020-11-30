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

    add_tags

    target_object.save!

    target_object
  end
  # rubocop:enable Metrics/AbcSize

  def prepare
    body = fetch_image || return

    @image_io = StringIO.new(body)
  end

  private

  attr_reader :image_io

  def add_tags
    # note that kleinodien uses the coverartarchive.org "types" as "tags"
    tags = metadata[:types] || return

    tags.each do |tag_name|
      target_object.tags << ImageTag.find_or_create_by_name(tag_name)
    end
  end

  def create_image
    image = Image.create!(coverartarchive_code: metadata[:id], import_order: import_order)
    image.file.attach(io: image_io, filename: "coverartarchiveorg_#{metadata[:id]}")

    image.save!

    image
  end

  def fetch_image
    CoverArtFetcher.call(import_request: import_request).body
  rescue ImportError::CanNotFetch => e
    Rails.logger.error(e)
    nil
  end

  def image
    @image ||= create_image
  end

  def import_request
    CoverArtImageImportRequest.create!(import_order: import_order, uri: metadata[:image])
  end
end
