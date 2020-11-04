# frozen_string_literal: true

# ImportOrder for a MusicBrainz release
class BrainzReleaseImportOrder < BrainzImportOrder
  def item
    return unless done?

    Release.find_by(brainz_code: code)
  end
end
