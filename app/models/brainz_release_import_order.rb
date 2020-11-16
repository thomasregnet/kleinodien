# frozen_string_literal: true

# ImportOrder for a MusicBrainz release
class BrainzReleaseImportOrder < BrainzImportOrder
  has_one(
    :cover_art_release_import_order,
    class_name:  'CoverArtReleaseImportOrder',
    foreign_key: :import_order_id,
    required:    false
  )

  def item
    return unless done?

    @item ||= Release.find_by(brainz_code: code)
  end

  def item_designation
    item&.title
  end
end
