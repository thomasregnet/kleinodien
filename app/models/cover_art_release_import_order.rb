# frozen_string_literal: true

# ImportOrder for a CoverArt release
class CoverArtReleaseImportOrder < CoverArtImportOrder
  def item
    return unless done?

    @item ||= Release.find_by(brainz_code: code)
  end

  def item_designation
    item&.title
  end
end
