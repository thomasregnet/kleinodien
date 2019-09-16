# frozen_string_literal: true

# Return the kleinodien class name for a MusicBrainz release
class ChooseBrainzReleaseTypeService < ServiceBase
  TYPE_FOR = {
    'Album' => 'Album',
    'Single' => 'Single'
  }.freeze

  DEFAULT_TYPE = 'Release'

  def initialize(args)
    @brainz_type = args[:brainz_type]
  end

  attr_reader :brainz_type

  def call
    type = TYPE_FOR[brainz_type]
    type || DEFAULT_TYPE
  end
end
