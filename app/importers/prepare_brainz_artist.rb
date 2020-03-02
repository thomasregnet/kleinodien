# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist < PrepareBrainzBase
  def initialize(import_request:, **args)
    super(args)
    @import_request = import_request
  end

  attr_reader :import_request

  private

  def prepare
    find_already_existing || proxy.get(import_request)
  end

  public

  def find_already_existing
    Artist.find_by(brainz_code: import_request.code)
  end
end
