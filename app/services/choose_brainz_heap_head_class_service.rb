# frozen_string_literal: true

# Choose the right kleinodien class name for a MusicBrainz release group
class ChooseBrainzHeapHeadClassService < ChooseBrainzHeapClassService
  def call
    "#{super}Head"
  end
end
