# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    proxy.get(request) unless complete_blueprint?

    artist = find_already_existing
    return artist if artist
  end

  # <artist
  #     type-id="e431f5f6-b5d2-343d-8b36-72607fffb74b"
  #     type="Group"
  #     id="1d93c839-22e7-4f76-ad84-d27039efc048">
  def complete_blueprint?
    return true if blueprint.type

    false
  end

  def find_already_existing
    find_already_existing_by_brainz_code unless complete_blueprint?

    find_already_existing_by_codes
  end

  def find_already_existing_by_brainz_code
    Artist.find_by(brainz_code: blueprint.id)
  end

  def find_already_existing_by_codes
  end

  def request
    # TODO: implement request
  end
end
