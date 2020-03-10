# frozen_string_literal: true

# Base class to persist MusicBrainz content
class PersistBrainzBase < PersistBase
  def persist_infix
    :brainz
  end
end
