# frozen_string_literal: true

# Choose the right kleinodien class name for a MusicBrainz release group
class ChooseBrainzReleaseHeadTypeService < ChooseBrainzReleaseTypeService
  def call
    "#{super}Head"
  end
end
