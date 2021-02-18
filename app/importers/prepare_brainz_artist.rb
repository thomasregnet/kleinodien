# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist < PrepareBrainzBase
  def initialize(stub:, **args)
    super(**args)
    @code = stub.brainz_code
    @stub = stub
  end

  attr_reader :code, :stub

  private

  def prepare
    return if proxy.cached?(:artist, code)
    return if Artist.find_by(brainz_code: code)

    proxy.get(:artist, code)
  end
end
