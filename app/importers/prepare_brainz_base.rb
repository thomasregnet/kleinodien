# frozen_string_literal: true

# Base class for PrepareBrainz classes
class PrepareBrainzBase < PrepareBase
  def persist_prepare_infix
    :brainz
  end
end
