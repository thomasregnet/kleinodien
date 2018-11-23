# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    return if find_already_existing

    blueprint.name_credits.each do |name_credit|
      prepare_brainz_artist(name_credit.artist)
    end

    nil
  end

  def find_already_existing
    # TODO: implement find_already_existing
  end

  def prepare_brainz_artist(name_credit)
    PrepareBrainzArtist.call(
      blueprint: name_credit,
      proxy:     proxy
    )
  end
end
