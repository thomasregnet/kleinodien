# frozen_string_literal: true

# ImportOrder for a MusicBrainz release
class BrainzReleaseImportOrder < BrainzImportOrder
  def item
    return unless done?

    @item ||= Release.find_by(brainz_code: code)
  end

  def item_designation
    item&.title
  end
end
